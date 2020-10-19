/*    Copyright 2014-2018 ARM Limited
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.arm.wa.uiauto.youtube;

import android.os.Bundle;
import android.os.SystemClock;
import android.support.test.internal.runner.ClassPathScanner;
import android.support.test.runner.AndroidJUnit4;
import android.support.test.uiautomator.UiObject;
import android.support.test.uiautomator.UiScrollable;
import android.support.test.uiautomator.UiSelector;

import com.arm.wa.uiauto.BaseUiAutomation;
import com.arm.wa.uiauto.ActionLogger;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

import static com.arm.wa.uiauto.BaseUiAutomation.FindByCriteria.BY_DESC;
import static com.arm.wa.uiauto.BaseUiAutomation.FindByCriteria.BY_ID;
import static com.arm.wa.uiauto.BaseUiAutomation.FindByCriteria.BY_TEXT;

@RunWith(AndroidJUnit4.class)
public class UiAutomation extends BaseUiAutomation {

    public static final String SOURCE_MY_VIDEOS = "my_videos";
    public static final String SOURCE_SEARCH = "search";
    public static final String SOURCE_TRENDING = "trending";

    public static final int WAIT_TIMEOUT_1SEC = 1000;
    public static final int VIDEO_SLEEP_SECONDS = 3;
    public static final int LIST_SWIPE_COUNT = 5;


    protected Bundle parameters;
    protected String packageID;

    @Before
    public void initialize() {
        parameters = getParams();
        packageID = getPackageID(parameters);
    }

    @Test
    public void setup() throws Exception {
        mDevice.setOrientationNatural();
        runApplicationInitialization();
    }

    @Test
    public void runWorkload() throws Exception {
        String videoSource = parameters.getString("video_source");
        String searchTerm = parameters.getString("search_term");
        UiObject video = getVideoObject(videoSource, searchTerm);
        testPlayVideo(video, videoSource);
        dismissAdvert();
        checkPlayerError();
        pausePlayVideo();
        checkVideoInfo();
        scrollRelated();
    }

    @Test
    public void teardown() throws Exception {
        mDevice.unfreezeRotation();
    }

    // Get application parameters and clear the initial run dialogues of the application launch.
    public void runApplicationInitialization() throws Exception {
        clearFirstRunDialogues();
        disableAutoplay();
    }

    // Sets the UiObject that marks the end of the application launch.
    public UiObject getLaunchEndObject() {
        UiObject launchEndObject = mDevice.findObject(new UiSelector()
                                          .resourceId(packageID + "menu_search"));
        return launchEndObject;
    }

    public void clearFirstRunDialogues() throws Exception {
        UiObject laterButton =
            mDevice.findObject(new UiSelector().textContains("Later")
                                               .className("android.widget.TextView"));
        if (laterButton.waitForExists(WAIT_TIMEOUT_1SEC)) {
           laterButton.click();
       }

        UiObject cancelButton =
            mDevice.findObject(new UiSelector().textContains("Cancel")
                                               .className("android.widget.Button"));
       if (cancelButton.waitForExists(WAIT_TIMEOUT_1SEC)) {
        cancelButton.click();
        }

        UiObject skipButton =
            mDevice.findObject(new UiSelector().textContains("Skip")
                                               .className("android.widget.TextView"));
        if (skipButton.waitForExists(WAIT_TIMEOUT_1SEC)) {
            skipButton.click();
        }

        UiObject gotItButton =
            mDevice.findObject(new UiSelector().textContains("Got it")
                                               .className("android.widget.Button"));
        if (gotItButton.waitForExists(WAIT_TIMEOUT_1SEC)) {
            gotItButton.click();
        }
    }

    public void disableAutoplay() throws Exception {
        UiObject moreoptions = 
            mDevice.findObject(new UiSelector().descriptionContains("More options"));
        if (moreoptions.exists()) {
            moreoptions.click();
        }
        else {
            clickUiObject(BY_DESC, "Account");
        }
        clickUiObject(BY_TEXT, "Settings", true);

        // On newer version autoplay has its own menu item so click twice to toggle
        UiObject autoplayMenuItem =
            mDevice.findObject(new UiSelector().textContains("Autoplay"));
        if (autoplayMenuItem.waitForExists(WAIT_TIMEOUT_1SEC)) {
            autoplayMenuItem.click();
            UiObject autoplayToggle =
                mDevice.findObject(new UiSelector().className("android.widget.Switch"));
            if (autoplayToggle.waitForExists(WAIT_TIMEOUT_1SEC)) {
                autoplayToggle.click();
            }
            mDevice.pressBack();
            mDevice.pressBack();
            return;
        }
        // Support older versions, autoplay toggle located under general settings
        clickUiObject(BY_TEXT, "General", true);

        // Don't fail fatally if autoplay toggle cannot be found
        UiObject autoplayToggle =
            mDevice.findObject(new UiSelector().textContains("Autoplay"));
        if (autoplayToggle.waitForExists(WAIT_TIMEOUT_1SEC)) {
            autoplayToggle.click();
        }
        mDevice.pressBack();

        // Tablet devices use a split with General in the left pane and Autoplay in the right so no
        // need to click back twice
        UiObject generalButton =
            mDevice.findObject(new UiSelector().textContains("General")
                                               .className("android.widget.TextView"));
        if (generalButton.exists()) {
            mDevice.pressBack();
        }
    }

    public UiObject getVideoObject(final String source, final String searchTerm) throws Exception {
        if (SOURCE_SEARCH.equalsIgnoreCase(source)) {
            clickUiObject(BY_DESC, "Search");
            UiObject textField = getUiObjectByResourceId(packageID + "search_edit_text");
            textField.setText(searchTerm);
            mDevice.pressEnter();
            
            // If a video exists whose title contains the exact search term, then play it
            // Otherwise click the first video in the search results
            UiObject thumbnail =
                mDevice.findObject(new UiSelector().resourceId(packageID + "thumbnail"));
            UiObject matchedVideo =
                thumbnail.getFromParent(new UiSelector().textContains(searchTerm));

            if (matchedVideo.exists()) {
                return matchedVideo;
            } else if (thumbnail.exists()) {
                return thumbnail;
            }

            matchedVideo = 
                mDevice.findObject(new UiSelector().resourceId(packageID + "title").textContains(searchTerm));
            if(matchedVideo.waitForExists(3000)) {
                return matchedVideo;
            }

            // Newer version (14.41.52) thumbnail object does not exist so grab view group searchTerm
            UiObject video = mDevice.findObject(new UiSelector().descriptionContains(searchTerm)
                                                                .className("android.view.ViewGroup"));
            return video;


        } else if (SOURCE_MY_VIDEOS.equalsIgnoreCase(source)) {
            UiObject libraryBtn = mDevice.findObject(new UiSelector().textContains("Library"));
            if(libraryBtn.exists()) {
                libraryBtn.click();
            } else {
                clickUiObject(BY_TEXT, "Account");
            }

            clickUiObject(BY_TEXT, "My Videos", true);

            UiObject thumbnail = 
                mDevice.findObject(new UiSelector().resourceId(packageID + "thumbnail"));

            if (!thumbnail.waitForExists(WAIT_TIMEOUT_1SEC * 3)) {
                throw new RuntimeException("There are no videos associated with this account, add at least one video");
            }

            return thumbnail;

        } else if (SOURCE_TRENDING.equalsIgnoreCase(source)) {
            clickUiObject(BY_DESC, "Trending");

            UiObject thumbnail =
                mDevice.findObject(new UiSelector().resourceId(packageID + "thumbnail"));
             
             if (thumbnail.exists()) {
                return thumbnail;
             }

            // Newer versions (14.41.52)
            UiObject trendingVideosView = 
                mDevice.findObject(new UiSelector().resourceId(packageID + "results"));
            
            // Return first view group in the list
            return trendingVideosView.getChild(new UiSelector().className("android.view.ViewGroup"));
            
        } else { // homepage videos
            UiScrollable list =
                new UiScrollable(new UiSelector().resourceId(packageID + "results"));
            if (list.exists()) {
                list.scrollForward();
            }

            UiObject thumbnail = 
                mDevice.findObject(new UiSelector().resourceId(packageID + "thumbnail"));
            if (thumbnail.exists()) {
                return thumbnail;
            } else {
                return list.getChild(new UiSelector().className("android.view.ViewGroup"));
            }
        }
    }

    public void testPlayVideo(final UiObject video, final String source) throws Exception {
        String testTag = "play";
        ActionLogger logger = new ActionLogger(testTag + "_" + source, parameters);

        logger.start();
        video.clickAndWaitForNewWindow();
        logger.stop();
    }

    public void dismissAdvert() throws Exception {
        UiObject advert =
            mDevice.findObject(new UiSelector().textContains("Visit advertiser"));
        if (advert.exists()) {
            UiObject skip =
                mDevice.findObject(new UiSelector().textContains("Skip ad"));
            if (skip.waitForExists(WAIT_TIMEOUT_1SEC*5)) {
                skip.click();
                sleep(VIDEO_SLEEP_SECONDS);
            }
        }
    }

    public void checkPlayerError() throws Exception {
        UiObject playerError =
            mDevice.findObject(new UiSelector().resourceId(packageID + "player_error_view"));
        UiObject tapToRetry =
            mDevice.findObject(new UiSelector().textContains("Tap to retry"));
        if (playerError.waitForExists(WAIT_TIMEOUT_1SEC) || tapToRetry.waitForExists(WAIT_TIMEOUT_1SEC)) {
            throw new RuntimeException("Video player encountered an error and cannot continue.");
        }
    }

    public void pausePlayVideo() throws Exception {
        UiObject player = getUiObjectByResourceId(packageID + "player_fragment_container");
        sleep(VIDEO_SLEEP_SECONDS);
        player.click();
        UiObject pauseBtn = mDevice.findObject(new UiSelector().descriptionContains("Pause video"));
        if(pauseBtn.waitForExists(300)) {
            pauseBtn.click();
            sleep(1); // Pause for a second
            mDevice.findObject(new UiSelector().descriptionContains("Play video")).click();
        } else {
            throw new RuntimeException("Unable to pause video");
        }
    }

    public void checkVideoInfo() throws Exception {
        UiObject expandButton =
            mDevice.findObject(new UiSelector().resourceId(packageID + "expand_button"));
        if (!expandButton.waitForExists(WAIT_TIMEOUT_1SEC)) {
            return;
        }
        // Expand video info
        expandButton.click();
        sleep(1); // short delay to simulate user action
        expandButton.click();
    }

    public void scrollRelated() throws Exception {
        String testTag = "scroll";

        // ListView of related videos and (maybe) comments
        UiScrollable list =
            new UiScrollable(new UiSelector().resourceId(packageID + "watch_list"));
        if (list.isScrollable()) {
            ActionLogger logger = new ActionLogger(testTag + "_down", parameters);
            logger.start();
            list.flingToEnd(LIST_SWIPE_COUNT);
            logger.stop();

            logger = new ActionLogger(testTag + "_up", parameters);
            logger.start();
            list.flingToBeginning(LIST_SWIPE_COUNT);
            logger.stop();
        }
        // After flinging, give the window enough time to settle down before
        // the next step, or else UiAutomator fails to find views in time
        sleep(VIDEO_SLEEP_SECONDS);
    }
}

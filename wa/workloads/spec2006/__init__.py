from wa import Parameter, Workload, File
from wa.utils.types import list_or_string
from dateutil.parser import parse
import datetime
import math
import os

SPEC_TARGET_PATH_BASE = '/data/local/tmp/spec2k6'

TARGET_BIN_DIRECTORY = '/data/local/tmp/bin'

TARGET_OUTPUT_DIRECTORY = '/sdcard/devlib-target' 

BASE_MACHINE_REFERENCE_TIMES = {'400.perlbench' : 9770, '401.bzip2' : 9650,
                                '403.gcc' : 8050, '429.mcf' : 9120, '445.gobmk' : 10490,
                                '456.hmmer' : 9330, '458.sjeng' : 12100,
                                '462.libquantum' : 20720, '464.h264ref' : 22130,
                                '471.omnetpp' : 6250, '473.astar' : 7020,
                                '483.xalancbmk' : 6900, '410.bwaves' : 13590,
                                '416.gamess' : 19580, '433.milc' : 9180, '434.zeusmp' : 9100,
                                '435.gromacs' : 7140, '436.cactusADM' : 11950,
                                '437.leslie3d' : 9400, '444.namd' : 8020, '447.dealII' : 11440,
                                '450.soplex' : 8340, '453.povray' : 5320, '454.calculix' : 8250,
                                '459.GemsFDTD' : 10610, '465.tonto' : 9840, '470.lbm' : 13740,
                                '481.wrf' : 11170, '482.sphinx3' : 19490}

SPEC_INT_TESTS = ['400.perlbench',
                  '401.bzip2',
                  '403.gcc',
                  '429.mcf',
                  '445.gobmk',
                  '456.hmmer',
                  '458.sjeng',
                  '462.libquantum',
                  '464.h264ref',
                  '471.omnetpp',
                  '473.astar',
                  '483.xalancbmk']

SPEC_FP_TESTS = ['410.bwaves',
                 '416.gamess',
                 '433.milc',
                 '434.zeusmp',
                 '435.gromacs',
                 '436.cactusADM',
                 '437.leslie3d',
                 '444.namd',
                 '447.dealII',
                 '450.soplex',
                 '453.povray',
                 '454.calculix',
                 '459.GemsFDTD',
                 '465.tonto',
                 '470.lbm',
                 '481.wrf',
                 '482.sphinx3']

ALL_TESTS = SPEC_INT_TESTS + SPEC_FP_TESTS

ALLOWED_TEST_NAMES = ['all', 'spec_int', 'spec_fp'] + ALL_TESTS

class Spec2006(Workload):

    name = 'spec2006'
    description = "This is an placeholder description"

    parameters = [
        Parameter('build_name', kind=str, mandatory=False,
                  description='Disabled for now. This parameter represents the binaries to be used based off compiler and version etc'),
        Parameter('test_names', kind=list_or_string, mandatory=True, allowed_values=ALLOWED_TEST_NAMES,
        		  description='Use this parameter to define which tests to run from the cpu2006 suite'),
        Parameter('run_type', kind=str, default='speed', allowed_values=['speed', 'throughput'],
        	       description='Only speed implemented so far, use this parameter to run spec2k6 as speed or throughput.')
    ]

    def __init__(self, target, **kwargs):
        super(Spec2006, self).__init__(target, **kwargs)
        self.incomplete_tests = []
        self.spec_int_scores = []
        self.spec_fp_scores = []
        if isinstance(self.test_names, str):
            self.test_names = [self.test_names]

        if 'all' in self.test_names:
        	self.test_names = ALL_TESTS
        elif 'spec_int' in self.test_names:
        	self.test_names = SPEC_INT_TESTS
        elif 'spec_fp' in self.test_names:
        	self.test_names = SPEC_FP_TESTS

    def init_resources(self, resolver):
        super(Spec2006, self).init_resources(resolver)
         

    def initialize(self, context):
        super(Spec2006, self).initialize(context)
        resource = File(self, "script/run_spec_2006_speed.sh")
        host_executable = context.get_resource(resource)
        self.run_spec_script = self.target.install(host_executable)
        
        #Remove base directory if it already exists
        if 'spec2k6' in self.target.list_directory('data/local/tmp'):
            command = 'rm -rf /data/local/tmp/spec2k6'
            self.target.execute(command, as_root=True)

        #Install spec2k6 on device
        self.target.execute('cd /data/local/tmp && mkdir spec2k6')
        for test in self.test_names:
            test_run_folder = os.path.join('spec2k6', test)
            test_run_folder = context.get_resource(File(self, test_run_folder), strict=False)
            if test_run_folder is None:
                self.logger.warning('Test folder does not exist for test: {}'.format(test))
                self.incomplete_tests.append(test)
                continue
            self.logger.info('Copying {} to device'.format(test))
            test_run_folder_target_dir = os.path.join(SPEC_TARGET_PATH_BASE, test)
            self.target.push(test_run_folder, test_run_folder_target_dir, timeout=300)
        

    def setup(self, context):
        super(Spec2006, self).setup(context)

    def run(self, context):
        super(Spec2006, self).run(context)
        if 'spec_output' in self.target.list_directory(TARGET_OUTPUT_DIRECTORY):
            self.target.execute('cd {} && rm -r spec_output'.format(TARGET_OUTPUT_DIRECTORY))
        self.target.execute('cd {} && mkdir spec_output'.format(TARGET_OUTPUT_DIRECTORY))
        for test_name in self.test_names:
            self.logger.info('*****RUNNING******: ' + test_name)
            if not self._does_test_folder_exist(test_name) or not self._does_run_folder_exist(test_name):
                self.logger.warning('Test folder does not exist for {}......skipping'.format(test_name))
                self.incomplete_tests.append(test_name)
                continue
            self.target.execute('cd {} && mkdir {}'.format(os.path.join(TARGET_OUTPUT_DIRECTORY, 'spec_output'), test_name))
            test_target_output_dir = os.path.join(TARGET_OUTPUT_DIRECTORY, 'spec_output', test_name)
            timing_output_file_path = os.path.join(test_target_output_dir, 'timing.txt')
            command = 'sh {} {} {} 2>&1 | tee {}'.format(self.run_spec_script, test_name, test_target_output_dir, timing_output_file_path)
            self.target.execute(command, as_root=True)

    def extract_results(self, context):
        super(Spec2006, self).extract_results(context)
        output_folder = os.path.join(TARGET_OUTPUT_DIRECTORY, 'spec_output')
        host_output_folder = os.path.join(context.output_directory, 'spec_output')
        self.target.pull(output_folder, host_output_folder)
        for test_name in self.test_names:
            if test_name in self.incomplete_tests:
        	    continue
            for file in os.listdir(os.path.join(host_output_folder, test_name)):
                if 'ref' in file and 'err' in file:
                    if os.stat(os.path.join(host_output_folder, test_name, file)).st_size != 0:
                        self.logger.warning('errors were found during run in {}'.format(file))
                        if test_name not in self.incomplete_tests:
                            self.incomplete_tests.append(test_name)

    def update_output(self, context):
        super(Spec2006, self).update_output(context)
        for test_name in self.test_names:
            if test_name in self.incomplete_tests:
                continue
            timings_file = os.path.join(context.output_directory, 'spec_output', test_name, 'timing.txt')
            self._parse_timings_file(context, timings_file, test_name)

        # Calculate and add benchmark group scores if number of complete tests >= 5
        if len(self.spec_int_scores) >= 5:
        	group_score = self._calculate_group_benchmark_score(self.spec_int_scores)
        	context.add_metric('spec_int_score', group_score, 'ratio_score')
        if len(self.spec_fp_scores) >=5:
        	group_score = self._calculate_group_benchmark_score(self.spec_fp_scores)
        	context.add_metric('spec_fp_score', group_score, 'ratio_score')

    def teardown(self, context):
        super(Spec2006, self).teardown(context)
        #Clean up outfiles 
        self.target.execute('cd {} && rm -r spec_output'.format(TARGET_OUTPUT_DIRECTORY))
        if len(self.incomplete_tests) > 0:
        	self.logger.warning('The following tests did not run correctly:{}'.format(self.incomplete_tests))
    
    def _does_run_folder_exist(self, test_name):
        folders_in_test_dir = self.target.execute('cd /data/local/tmp/spec2k6/{} && ls'.format(test_name), as_root=True)
        if 'run' not in folders_in_test_dir:
            return False
        return True

    def _does_test_folder_exist(self, test_name):
        folders_in_test_dir = self.target.execute('cd /data/local/tmp/spec2k6 && ls', as_root=True)
        if test_name not in folders_in_test_dir:
            return False
        return True

    def _parse_timings_file(self, context, filepath, test_name):
        total_time = datetime.timedelta()
        with open(filepath) as fh:
            for line in fh:
                if not 'real' in line:
                    continue
                elapsed_time = parse(line.split('real')[0].strip()).time()
                (h, m, s) = elapsed_time.strftime('%H:%M:%S.%f').split(':')
                total_time += datetime.timedelta(hours=int(h), minutes=int(m), seconds=float(s))
        classifiers = {'run_time_seconds' : total_time.seconds}

        if total_time.seconds == 0:
            self.incomplete_tests.append(test_name)
            return

        benchmark_ratio = self._calculate_test_benchmark_ratio(test_name, total_time)
        context.add_metric(test_name, benchmark_ratio, 'ratio_score', classifiers=classifiers)

        if test_name in SPEC_INT_TESTS:
            self.spec_int_scores.append(benchmark_ratio)
        else:
            self.spec_fp_scores.append(benchmark_ratio)

    @staticmethod
    def _calculate_test_benchmark_ratio(test_name, elapsed_time):
        return round(BASE_MACHINE_REFERENCE_TIMES[test_name] / elapsed_time.seconds, 4)

    @staticmethod
    def _calculate_group_benchmark_score(benchmark_ratios):
        return math.exp(math.fsum(math.log(benchmark_ratio) for benchmark_ratio in benchmark_ratios) / len(benchmark_ratios))

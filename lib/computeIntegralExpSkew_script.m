% COMPUTEINTEGRALEXPSKEW_SCRIPT   Generate static library computeIntegralExpSkew
%  from computeIntegralExpSkew.
% 
% Script generated from project 'computeIntegralExpSkew.prj' on 20-Oct-2021.
% 
% See also CODER, CODER.CONFIG, CODER.TYPEOF, CODEGEN.

%% Create configuration object of class 'coder.EmbeddedCodeConfig'.
cfg = coder.config('lib','ecoder',true);
cfg.TargetLang = 'C++';
cfg.GenerateCodeMetricsReport = true;
cfg.GenerateCodeReplacementReport = true;
cfg.HighlightPotentialDataTypeIssues = true;
cfg.GenerateReport = true;
cfg.ReportPotentialDifferences = false;
cfg.FilePartitionMethod = 'SingleFile';
cfg.CppNamespace = 'sun_vs';
cfg.RowMajor = true;
cfg.GenCodeOnly = true;
cfg.TargetLangStandard = 'C++11 (ISO)';
cfg.MaxIdLength = 1024;
cfg.CppInterfaceClassName = 'computeIntegralExpSkew_c';

%% Define argument types for entry-point 'computeIntegralExpSkew'.
ARGS = cell(1,1);
ARGS{1} = cell(4,1);
ARGS{1}{1} = coder.typeof(0);
ARGS{1}{2} = coder.typeof(0);
ARGS{1}{3} = coder.typeof(0);
ARGS{1}{4} = coder.typeof(0);

%% Invoke MATLAB Coder.
codegen -config cfg computeIntegralExpSkew -args ARGS{1}


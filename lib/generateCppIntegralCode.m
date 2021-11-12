%% codegen

% Set configuration for Code Generation 
cfg = coder.config('lib');
cfg.GenerateMakefile = false;
cfg.GenCodeOnly = true; % Code generator produces C++ source code, but does not invoke make
                        % command or build object
cfg.GenerateExampleMain = 'DoNotGenerate'; % Code Generator does not generate an example main function
cfg.TargetLang = 'C++';
cfg.CastingMode = 'Standards'; % Data type casting conforms to MISRA standards
cfg.GenerateReport = true; 
cfg.GenerateCodeMetricsReport = true; % Generate Metrics report for static code analyzation
cfg.CppInterfaceStyle = 'Functions'; % = 'Methods';
%cfg.CppInterfaceClassName = 'computeIntegralExpSkew_class';
cfg.HighlightPotentialDataTypeIssues = true; % The code generation report highlights MATLAB code that 
                                             % results in single-precision or double-precision operations 
                                             % in the generated C/C++ code. If you have Fixed-Point Designer™, 
                                             % the report also highlights expressions in the MATLAB code that 
                                             % result in expensive fixed-point operations in the generated code.
cfg.PreserveArrayDimensions = true; % Generate code that uses N-dimensional indexing 
%cfg.PurelyIntegerCode = true; % The Code generator does not allow floating point data or operation. 
cfg.SaturateOnIntegerOverflow = true; % Code generator produces code to handle integer overflow 
% Generate C++-Code of function computeIntegralExpSkew
codegen computeIntegralExpSkew -config cfg -v...
    -args {0,0,0,0}
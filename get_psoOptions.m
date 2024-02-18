%                       |
%                       |_Vars------> PSO VARIABLES
%                       |   |_SwarmSize--> Swarm Size. (Also known as population size)
%                       |   |_Iterations-> Maximum Iterations. (Used to terminate the algorithm. see also: Terminate element below)
%                       |   |_ErrGoal----> Error goal. (Also used to terminate the algorithm. see also: Terminate element below)
%                       |   |_Dim--------> Dimensions of the problem. This determines the particle size.
%                       |
%                       |_SParams---> STRATERGY PARAMETERS
%                       |   |_c1---------> Cognitive Acceleration
%                       |   |_c2---------> Social Acceleration
%                       |   |_c3---------> Neighborhood Acceleration
%                       |   |_w_start----> Value of velocity Weight at the begining
%                       |   |_w_end------> Value of velocity Weight at the end of the pso iterations
%                       |   |_w_varyfor--> The fraction of maximum iterations, for which w is linearly varied
%                       |   |_Vmax-------> Maximum velocity step
%                       |   |_Nhood------> Neighborhood size (nhood=1 ==> 2 neighbors, one on each side)
%                       |
%                       |_Obj-------> OBJECTIVE FUNCTION OPTIONS
%                       |   |_f2eval-----> Function/System to optimize (Type Fuzzy if u want to tune an FIS)
%                       |   |_GM---------> Value of Global Minima (Required if Terminate.Err is set. i.e error goal is (one of) the termination criteria).
%                       |   |_lb---------> Lower bounds of Initialization (You may use Asymmetrical Initialization. These bounds don't limit the search space.)
%                       |   |_ub---------> Upper bounds of Initialization (Rather, they are used to Initialize the particles. See: An Empirical Study of PSO (Ebenhart and Shi)
%                       |
%                       |_Terminate-> TERMINATION OPTIONS (Multiple options are allowed)
%                       |   |_Iters------> Use Vars.MaxIt as a termination criterion.   1=Yes, 0=No
%                       |   |_Err--------> Use Vars.ErrGoal as a termination criterion. 1=Yes, 0=No
%                       |
%                       |_Disp------> TEXT MODE DISPLAY OPTIONS
%                       |   |_Interval---> Notify about the progress after these many iterations. 0=Don't Notify
%                       |   |_Header-----> Display the PSO Options header. 0 = Hide, 1 = Show
%                       |   |_Progress---> Display the progress of the Algorithm. 0 = Hide, 1 = Show
%                       |   |_Footer-----> Display Footer (contains experimental results). 0 = Hide, 1 = Show
%                       |
%                       |_Save------> OPTIONS FOR SAVING RESULTS IN A TEXT FILE
%                       |   |_File-------------> Base name of the Output Text File. (see options below for automation options)
%                       |   |_IncludeFnName----> Prefix the name of the name of the Objective function to the file name e.g. DeJong_Results. 1=Yes, 0=No
%                       |   |_IncludeDim-------> Suffix the number of dimensions. DeJong_Results_10d. 1=Yes, 0=No
%                       |   |_IncludeSwarmSize-> Suffix the size of swarm. DeJong_Results_10d20p. 1=Yes, 0=No
%                       |   |_Interval---------> Save after this number of iterations. 0=Don't save the progress report. 
%                       |   |_Header-----------> Save the header information (also see: Disp)
%                       |   |_Footer-----------> Save the Footer information (also see: Disp)
%                       | 
%                       |_Fuzzy-----> FUZZY OPTIONS
%                           |_FIS-------------> An FIS file that contains the system to be optimize. (note: The actual file should have a .fis extension, although u may or may not include it here)
%                           |_DataFile--------> An valid Excel file containing Training Data. The FIS will be tuned to match this data.
%                           |_InitFunc--------> A function to initialize the Swarm using the FIS. (String or Function handle)
%                           |_ValidateFunc----> A function to Validate the Swarm each time particles are moved. This is required to change the co-ordinates of the particles which have bad value of membership function parameters.
%                           |_ErrorFunc-------> A function to evaluate the fitness of the fuzzy system. (note: Fitness is expressed in terms of mean square error. So, more fit functions would return a lower value of error)
%                           |_TuneInputs------> Tune the input membership functions
%                           |_TuneOutputs-----> Tune the output membership functions
%
% History        :   Author      :   JAG (Jagatpreet Singh)
%                   Created on  :   06252003 (Wednesday. 25th June, 2003)
%                   Comments    :   Enjoy!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       把计砞﹚('SwarmSize'=采竤计'Iterations'=簍て计'Dim'=jobs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function psoOptions = get_psoOptions()
global    jobs 
psoOptions = struct( ...
    ... %Option FLAGS
    'Flags', struct(...
    'ShowViz',          0, ...      %Show visualization of the particles
    'Neighbor',         0), ...     %Use neighborhood acceleration (in addition to global acceleration)
    ... %Variables of the PSO   采竤跑计砞﹚
    'Vars', struct(...    
    'SwarmSize',  20, ...     %Swarm Size 700            <----------------------------------------------癬﹍壁竤采计
    'Iterations',  1500,...    %Maximum Iterations 10000    <---------------------------------------------簍て碭 2000
    'ErrGoal',     1e-10, ...  %Error goal
    'Dim',         jobs ), ...   %Dimensions of the problem    <-------------------------------------------------  ﹚璶タ  膀
    ...  %Stratergy Parameters 把计砞﹚
    'SParams', struct(... 
    'c1',       1.5, ...      %Cognitive Acceleration         セ琌 2                        厩策盽计砰粄舦   5.1417
    'c2',       1.5, ...      %Social Acceleration            セ琌 1.49445                                            厩策盽计俱砰穦舦   3.1417
    'c3',       1, ...      %Neighborhood Acceleration  1  2
    'w_start',  0.5, ...   %Value of velocity Weight at the begining 0.09                                     癬﹍硉  0.09
    'w_end',    0.06, ...    %Value of velocity Weight at the end of the pso iterations 0.0004              Μ滥硉? 0.001
    'w_varyfor',0.7,...     %The fraction of maximum iterations, for which w is linearly varied  0.7
    'Vmax',     4,...     %Maximum velocity step  6
    'Chi',      0.8, ...      %Constriction factor 1  0.8
    'Nhood',    2 ), ...    %Neighborhood size (nhood=1 ==> 2 neighbors, one on each side) 1
    ...  %Objective Function Options
    'Obj', struct(...    
    'GM',           0, ...      %Value of Global Minima (Required if Error goal is a termination criteria). 0
    'lb',           2, ...    %Lower bounds of Initialization 1    2
    'ub',           10 ), ...  %Upper bounds of Initialization 26  7
    ... %Termination Options
    'Terminate', struct(...
    'Iters',        1, ...      %Use Vars.MaxIt for termination
    'Err',          1), ...     %Use Vars.ErrGoal for termintion
    ... %Display Options
    'Disp', struct( ...
    'Interval',    10, ...     %Notify about the progress after these many iterations       –X计陪ボ氮
    'Header',      1,  ...     %Display the PSO Options header. 0 = hide, 1 = show
    'Progress',    1,  ...     %Display the progress of the Algorithm. 0 = hide, 1 = show
    'Footer',      1 ),  ...   %Display Footer (contains experimental results). 0 = hide, 1 = show
    ... %Saving Options
    'Save', struct(...
    'File',        'Results', ...  %Base name of the Output Text File. (see options below for automation options)
    'IncludeFnName',    1, ...     %Prefix the name of the name of the Objective function to the file name e.g. DeJong_Results
    'IncludeDim',       1, ...     %Suffix the number of dimensions. DeJong_Results_10d
    'IncludeSwarmSize', 1, ...     %Suffix the size of swarm. DeJong_Results_10d20p
    'Interval',         10,...     %Save after this number of iterations   
    'Header',           1, ...     %Save the header information (see Disp)
    'Footer',           1 ) , ...  %Save the Footer information (see Disp)
    ... %info: the PSO Toolbox can used to tune the membership functions of an FIS. Set the options below.
    ... %Fuzzy Options 
    'Fuzzy', struct( ...
    'FIS',          'tipper', ...       %FIS file that contains the system to be optimize. (note: The file should end with a .fis extension)
    'DataFile',     'tipperData', ...   %An Excel File containing Training Data. The FIS will be tuned to match this data.
    'InitFunc',     @initfuzzy, ...     %A function to initialize the Swarm using the FIS
    'ValidateFunc', @validatefuzzy, ... %A function to Validate the Swarm each time particles are moved. This is required to change the co-ordinates of the particles which have bad value of membership function parameters.
    'ErrorFunc',    @fuzEvalFitness,... %A function to evaluate the fitness of the fuzzy system. (note: Fitness is expressed in terms of mean square error. So, more fit functions would return a lower value of error)
    'TuneInputs',    1, ...             %Tune the input membership functions
    'TuneOutputs',   1) ...             %Tune the output membership functions
    );
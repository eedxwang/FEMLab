function files = generate_files(file_path, file_name)

files = struct();

files.file_name = file_name;
files.file_path = file_path;
files.mesh_file = fullfile(file_path, [file_name, '.msh']);
files.results = fullfile(file_path, 'results');
files.finfo = fullfile(files.results, 'finfo.mat');
files.setfile = fullfile(file_path, 'settings.txt');
files.respth = fullfile(files.results, file_name);
files.pltpth = fullfile(file_path, 'plots');
files.pltpth_mesh = fullfile(files.pltpth, [file_name, '_mesh']);
files.pltpth_pot = fullfile(files.pltpth, [file_name, '_potential']);
files.pltpth_absB = fullfile(files.pltpth, [file_name, '_absB']);
files.pltpth_quivB = fullfile(files.pltpth, [file_name, '_quivB']);
files.pltpth_contB = fullfile(files.pltpth, [file_name, '_contB']);
files.pltpth_sliceB = fullfile(files.pltpth, [file_name, '_sliceB']);
files.pltpth_abstriB = fullfile(files.pltpth, [file_name, '_abstriB']);
files.pltpth_flinesB = fullfile(files.pltpth, [file_name, '_flinesB']);
files.pltpth_absE = fullfile(files.pltpth, [file_name, '_absE']);
files.pltpth_quivE = fullfile(files.pltpth, [file_name, '_quivE']);
files.pltpth_contE = fullfile(files.pltpth, [file_name, '_contE']);
files.pltpth_sliceE = fullfile(files.pltpth, [file_name, '_sliceE']);
files.pltpth_abstriE = fullfile(files.pltpth, [file_name, '_abstriE']);
files.pltpth_flinesE = fullfile(files.pltpth, [file_name, '_flinesE']);
files.pltpth_absA = fullfile(files.pltpth, [file_name, '_absA']);
files.pltpth_quivA = fullfile(files.pltpth, [file_name, '_quivA']);
files.pltpth_contA = fullfile(files.pltpth, [file_name, '_contA']);
files.pltpth_abstriA = fullfile(files.pltpth, [file_name, '_abstriA']);
files.pltpth_valid1 = fullfile(files.pltpth, [file_name, '_validation_comp']);
files.pltpth_valid2 = fullfile(files.pltpth, [file_name, '_validation_error']);
files.f_changed = 1;

if(exist(files.pltpth, 'dir') ~= 7)
    mkdir(files.pltpth)
end

if(exist(files.results, 'dir') ~= 7)
    mkdir(files.results)
end
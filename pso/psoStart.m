%% parameters for an optimization
sc = cell(1,3);
sc{1} = SpaceConstraint(0.0, 1.0, 0.0001);  % red space
sc{2} = SpaceConstraint(0.0, 1.0, 0.0001);  % green space 
sc{3} = SpaceConstraint(0.0, 1.0, 0.0001);  % blue space
params = OptimizationParams(sc, 8/256);
% our objective is to minimize entropy difference
params.objective = Objective.Minimize;
params.swarmSize = 5;
params.iterations = 10;

%% get an image that we want to optimize
im_w = 32;
im_h = 32;
channels = 3;
image = 0.5 + 0.3 .* randn(im_w, im_h, channels);
image(image>1.0) = 1.0;
image(image<0.0) = 0.0;
imshow(image);

%% fitness delegate - i.e. the class that actually does all the job
fd = FitnessDelegate(image, fullfile(pwd, 'results'));

%% optimizer
pso = ParticleSwarmOptimizer(params, fd);
[a,b] = pso.Optimize();
imshow(a);
disp(b);

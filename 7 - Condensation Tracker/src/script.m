close all
clear all
load('data/params')
params.draw_plots = 1;
params.hist_bin = 16;
params.alpha = 0.5;
params.sigma_observe = 0.1;
params.model = 0;
params.num_particles = 300;
params.sigma_position = 3;
params.sigma_velocity = 1;
params.initial_velocity = [-5, -1];
% Parameters for the bonus
%{
params.alpha = 0.1;
params.sigma_observe = 0.2;
params.model = 1;
params.sigma_position = 2;
params.sigma_velocity = 1;
params.initial_velocity = [-5, -1];
%}
videoName = 'video1';
condensationTracker(videoName,params)
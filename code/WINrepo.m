%% Analysis of Funding Agency Stats

dirO = '/Volumes/Expansion/Documents/WINrepo/';

%% Analysis of the total on the transparent reporting scale


ts = []; % transparency score
% % % agency = [];

for i = 1:size(FAS, 1)
    ts = [ts; sum(FAS(i, :))];
% % %     agency = [agency; [table2array(FAS(i, 2)) table2array(FAS(i, 3)) table2array(FAS(i, 4))]];
end

% Horizontal bar plot
colors = [0.7294    0.4510    0.2039;...
    0.7294    0.4510    0.2039;...
    0.7294    0.4510    0.2039;...
    0.7294    0.4510    0.2039;...
    0.7294    0.4510    0.2039;...
    0.7294    0.4510    0.2039;...
    0.7294    0.4510    0.2039;...
    0.7294    0.4510    0.2039;...
    0.8392    0.8314    0.8314;...
    0.8392    0.8314    0.8314;...
   0.8392    0.8314    0.8314;...
    0.8392    0.8314    0.8314;...
    0.8392    0.8314    0.8314;...
    0.8392    0.8314    0.8314;...
    0.9882    0.7922    0.3255;...
    0.9882    0.7922    0.3255;...
    0.9882    0.7922    0.3255;...
    0.9882    0.7922    0.3255];

[B,I] = sort(ts);
b = barh(B(1:18), 'FaceColor', 'flat')
b.CData = colors;
yticks([1:18])
yticklabels({'MSC (EU, list)','SNSF (Switzerland, tabular)', 'PRIN (Italy, list)', 'SRDA (Slovakia, report)', 'ERC (EU, tabular)', 'VR (Sweden, tabular)', 'FWO (Belgiumm, report)',...
    'ANR (France, report)', 'SNSF (Switzerland, tabular)', 'DFG (Germany, report)', 'NWO (Netherlands, report)',...
    'FWO (Belgium (tabular)', 'FNRS (Belgium, tabular)', 'The Wellcome Trust (UK, report)', ...
    'MRC (UK, report)', 'The Royal Society (UK, report)', 'BBSRC (UK, tabular)', 'The Wellcome Trust (UK, tabular)'})


saveas(gcf,[dirO 'TransparencyScale.svg']);



%Possible total = 10
%Gold = 10
%Silver = 6-9
%Bronze = 1-5

[0.8392    0.8314    0.8314]
[0.7294    0.4510    0.2039]

%% Percentage of funders reporting gender

Pg = find(table2array(FAS(:, 3)) == 1);
Po = find(table2array(FAS(:, 3)) == 0);

colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
ax = gca();
h = pie([size(Pg, 1) size(Po, 1)])
labels = {'Yes','No'};
ax.Colormap = colors; 
% % % lgd = legend(labels);
% % % lgd.Layout.Tile = 'east';
colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
set(findobj(h,'type','text'),'fontsize',20)
% % % title('Gender', 'FontSize', 25)

saveas(gcf,[dirO 'GenderP.svg']);


%% Percentage of funders reporting ethnicity

Pg = find(table2array(FAS(:, 4)) == 1);
Po = find(table2array(FAS(:, 4)) == 0);

colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
ax = gca();
h = pie([size(Pg, 1) size(Po, 1)])
labels = {'Yes','No'};
ax.Colormap = colors; 
% % % lgd = legend(labels);
% % % lgd.Layout.Tile = 'east';
colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
set(findobj(h,'type','text'),'fontsize',20)
% % % title('Gender', 'FontSize', 25)

saveas(gcf,[dirO 'EthnicityP.svg']);

%% Percentage of funders reporting disability

Pg = find(table2array(FAS(:, 5)) == 1);
Po = find(table2array(FAS(:, 5)) == 0);

colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
ax = gca();
h = pie([size(Pg, 1) size(Po, 1)])
labels = {'Yes','No'};
ax.Colormap = colors; 
% % % lgd = legend(labels);
% % % lgd.Layout.Tile = 'east';
colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
set(findobj(h,'type','text'),'fontsize',20)
% % % title('Gender', 'FontSize', 25)

saveas(gcf,[dirO 'DisabilityP.svg']);

%% Percentage of funders reporting age

Pg = find(table2array(FAS(:, 6)) == 1);
Po = find(table2array(FAS(:, 6)) == 0);

colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
ax = gca();
h = pie([size(Pg, 1) size(Po, 1)])
labels = {'Yes','No'};
ax.Colormap = colors; 
% % % lgd = legend(labels);
% % % lgd.Layout.Tile = 'east';
colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
set(findobj(h,'type','text'),'fontsize',20)
% % % title('Gender', 'FontSize', 25)

saveas(gcf,[dirO 'AgeP.svg']);

%% Percentage of funders reporting applicants

Pg = find(table2array(FAS(:, 7)) == 1);
Po = find(table2array(FAS(:, 7)) == 0);

colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
ax = gca();
h = pie([size(Pg, 1) size(Po, 1)])
labels = {'Yes','No'};
ax.Colormap = colors; 
% % % lgd = legend(labels);
% % % lgd.Layout.Tile = 'east';
colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
set(findobj(h,'type','text'),'fontsize',20)
% % % title('Gender', 'FontSize', 25)

saveas(gcf,[dirO 'ApplicantsP.svg']);

%% Percentage of funders reporting longitudinal

Pg = find(table2array(FAS(:, 8)) == 1);
Po = find(table2array(FAS(:, 8)) == 0);

colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
ax = gca();
h = pie([size(Pg, 1) size(Po, 1)])
labels = {'Yes','No'};
ax.Colormap = colors; 
% % % lgd = legend(labels);
% % % lgd.Layout.Tile = 'east';
colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
set(findobj(h,'type','text'),'fontsize',20)
% % % title('Gender', 'FontSize', 25)

saveas(gcf,[dirO 'LongitudinalP.svg']);

%% Percentage of funders reporting reusable

Pg = find(table2array(FAS(:, 9)) == 1);
Po = find(table2array(FAS(:, 9)) == 0);

colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
ax = gca();
h = pie([size(Pg, 1) size(Po, 1)])
labels = {'Yes','No'};
ax.Colormap = colors; 
% % % lgd = legend(labels);
% % % lgd.Layout.Tile = 'east';
colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
set(findobj(h,'type','text'),'fontsize',20)
% % % title('Gender', 'FontSize', 25)

saveas(gcf,[dirO 'ReusableP.svg']);

%% Percentage of funders reporting accessible

Pg = find(table2array(FAS(:, 10)) == 1);
Po = find(table2array(FAS(:, 10)) == 0);

colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
ax = gca();
h = pie([size(Pg, 1) size(Po, 1)])
labels = {'Yes','No'};
ax.Colormap = colors; 
% % % lgd = legend(labels);
% % % lgd.Layout.Tile = 'east';
colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
set(findobj(h,'type','text'),'fontsize',20)
% % % title('Gender', 'FontSize', 25)

saveas(gcf,[dirO 'AccessibleP.svg']);

%% Percentage of funders reporting interoperable

colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
ax = gca();
h = pie([15 0])
labels = {'Yes','No'};
ax.Colormap = colors; 
% % % lgd = legend(labels);
% % % lgd.Layout.Tile = 'east';
colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
set(findobj(h,'type','text'),'fontsize',20)
% % % title('Gender', 'FontSize', 25)

saveas(gcf,[dirO 'InteroperableP.svg']);

%% Percentage of funders reporting findable

colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
ax = gca();
h = pie([13 2])
labels = {'Yes','No'};
ax.Colormap = colors; 
% % % lgd = legend(labels);
% % % lgd.Layout.Tile = 'east';
colors = [0.7137    0.8196    0.8706;   %orange
    0.9608    0.7098    0.8588]; % purple
set(findobj(h,'type','text'),'fontsize',20)
% % % title('Gender', 'FontSize', 25)

saveas(gcf,[dirO 'FindableP.svg']);

%% Save

close all
cd(dirO)
save('Winrepo.mat')
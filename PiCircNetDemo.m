%% Pi digit connectivity visualization (digits 1-1000)

% First 1000 digits of pi after decimal point
Group = getPi(1000);

% Build adjacency matrix: connect each digit to its next neighbor (off-diagonal)
Data = diag(ones(1, 999), -1);

% Sort nodes by group for grouped layout
[Group, ind] = sort(Group);
Data = Data(ind, ind);              % Reorder adjacency matrix
Data = Data + Data.' + eye(1000);   % Make symmetric and add self-loops

% Define group (digit) names and custom colors
groupName = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
colorList = [239, 65, 75; 230, 115, 48; 229, 158, 57; 232, 136, 85; 239, 199, 97;
    144, 180, 116; 78, 166, 136; 81, 140, 136; 90, 118, 142; 43, 121, 159] ./ 255;

% Create figure with black background
figure()
set(gca, 'Color', [0, 0, 0])

% Initialize circular network chart
CNPI = circNetChart(Data);

% Node and edge appearance (uniform sizes)
CNPI.NodeSizeLim   = [0.01, 0.01];
CNPI.EdgeWidthLim  = [0.005, 0.005];

% Group layout configuration
CNPI.Group              = Group;
CNPI.GroupSep           = 1/8;              % Gap between groups (1/8 of full circle)
CNPI.GroupName          = groupName;
CNPI.GroupLabelRadius   = 1.05;

% RenderingMethod : interp
CNPI.NodeColor         = colorList(Group + 1, :);  
CNPI.RenderingMethod   = 'interp';            

% Edge curvature (full Bezier curve)
CNPI.Curvature = 1;

% Render the chart
CNPI = CNPI.draw();

% Hide individual node labels
CNPI.setLabel('Visible', 'off')

% Style group labels (digit labels around the circle)
CNPI.setGroupLabel('FontSize', 25, 'FontName', 'Monospaced', ...
    'FontWeight', 'bold', 'Color', 'w')
function varargout = my_face_rec(varargin)
clc
addpath('..\face_detection');
addpath('..\common');
addpath('..\face_recognition\PCA');
addpath('..\face_recognition\LDA');
addpath('..\face_recognition\PCA_LDA');
addpath('..\face_recognition\MPCA');
addpath('..\face_recognition\MPCA_LDA');

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @my_face_rec_OpeningFcn, ...
                   'gui_OutputFcn',  @my_face_rec_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function my_face_rec_OpeningFcn(h, eventdata, data, varargin)
data.output = h;
guidata(h, data);

function varargout = my_face_rec_OutputFcn(h, eventdata, data) 
varargout{1} = data.output;

%检测人脸打开图片按钮的回调函数
function pushbutton6_Callback(h, eventdata, data)
[filename, path] = uigetfile('*', 'Select input image');
img = imread([path,filesep, filename]);
[bbox, ~, img] = my_face_detector(img);
axes(data.axes1);
imshow(img)
set(data.text_state, 'String', ['打开图片成功，检测到', num2str(size(bbox,1)), '个人脸！']);

names = fieldnames(data);
n = length(names);
k=1;
for i=1:n
    hh = getfield(data,names{i});
    if ishandle(hh)
        ddd{k,1} = [names{i},'        ',mat2str(get(hh,'position'),4)];
        dd{k,1} = names{i}; dd{k,2} = get(hh); 
        k=k+1;
    end    
end
writeTextList(ddd,'dd.txt');
save('dd','dd');




function popupmenu1_CreateFcn(h, eventdata, data)
if ispc && isequal(get(h,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(h,'BackgroundColor','white');
end


%人脸库解析按钮的回调函数
function pushbutton7_Callback(h, eventdata, data)
path = uigetdir('*','Select input image');

id_str = get(data.edit9, 'String');
id_str = strtrim(id_str); %去除首位多余空白
temp_cell = regexp(id_str, ',', 'split'); %使用正则表达式匹配
start_index = str2double(temp_cell{1});
end_index = str2double(temp_cell{2});
databaseInfo = loadDatabase(path, @(in) in(start_index:end_index));
data.newSize = [15, 15];
data.N = databaseInfo.N;
data.C = databaseInfo.C;
save('databaseInfo.mat','databaseInfo');
set(data.text_state, 'String', '解析人脸库完成,将数据保存到 ./databaseInfo.mat ！');
t1=min(data.N, data.newSize(1)*data.newSize(2));
set(data.edit1, 'string', num2str(t1-1));
set(data.edit2, 'string', num2str(min(data.C , t1)-1));
set(data.edit8, 'String', '15,15');
set(data.radiobutton1, 'Value', 1);
guidata(h, data);


% 采用测试集按钮的回调函数
function pushbutton9_Callback(h, eventdata, data)
load('testInfo.mat');
h_uipanel12 = get(data.uipanel12, 'SelectedObject');
methodName = get(h_uipanel12, 'String');
switch methodName
    case 'PCA'
        [test_label, rate] = pca_test('', testInfo.name_list, @eulerDis, testInfo.label_list);
    case 'LDA'
        [test_label, rate] = lda_test('', testInfo.name_list, @eulerDis, testInfo.label_list);
    case 'MPCA'
        [test_label, rate] = mpca_test('', testInfo.name_list, @eulerDis, testInfo.label_list);
    case 'PCA+LDA'
        [test_label, rate] = pca_lda_test('', testInfo.name_list, @eulerDis, testInfo.label_list);
    case 'MPCA+LDA'
        [test_label, rate] = mpca_lda_test('', testInfo.name_list, @eulerDis, testInfo.label_list);
end
set(data.text_state, 'String', ['对', methodName, '测试完成！识别的准确率是', num2str(rate)]);

function edit1_CreateFcn(h, eventdata, data)
if ispc && isequal(get(h,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(h,'BackgroundColor','white');
end


function edit2_CreateFcn(h, eventdata, data)
if ispc && isequal(get(h,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(h,'BackgroundColor','white');
end


function edit5_CreateFcn(h, eventdata, data)
if ispc && isequal(get(h,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(h,'BackgroundColor','white');
end


function text_state_CreateFcn(h, eventdata, data)
set(h,'String', '');


function pushbutton11_Callback(h, eventdata, data)
obj = videoinput('winvideo', 1);
set(obj, 'ReturnedColorSpace', 'rgb');
preview(obj);
pause(3);
frame = getsnapshot(obj);
[bbox, ~, frame] = my_face_detector(frame);
axes(data.axes1);
imshow(frame);
delete(obj);
set(data.text_state, 'String', ['打开摄像头成功，检测到', num2str(size(bbox,1)), '个人脸！']);

function axes1_CreateFcn(h, eventdata, data)
guidata(h, data);


% 划分数据库的回调函数
function pushbutton12_Callback(h, eventdata, data)
load('databaseInfo.mat', 'databaseInfo');
str = get(data.popupmenu1, 'string');
i = get(data.popupmenu1, 'value');
if strcmp(str{i}, '选择第一张')
    choose = @(in) in(1);
else strcmp(str{i}, '选择最后一张')
    choose = @(in) in(end);
end

[trainInfo, testInfo] = divideSet(databaseInfo, choose);
save('trainInfo.mat', 'trainInfo');
save('testInfo.mat', 'testInfo');
set(data.text_state, 'string', '划分数据库完成！');
set(data.radiobutton1, 'Value', 1);
t1=min(trainInfo.N, data.newSize(1)*data.newSize(2));
set(data.edit1, 'String', num2str(t1-1));
set(data.edit2, 'String', num2str(min(trainInfo.C, t1)-1));
guidata(h, data);

% 训练按钮的回调函数
function pushbutton13_Callback(h, eventdata, data)
load('trainInfo.mat');
str_newSize = get(data.edit8, 'String');
str_newSize = strtrim(str_newSize); %去除首位多余空白
temp_cell = regexp(str_newSize, ',', 'split'); %使用正则表达式匹配
newSize = [str2double(temp_cell{1}), str2double(temp_cell{2})];
m1 = str2double(get(data.edit1, 'String'));
m2 = str2double(get(data.edit2, 'String'));
p = str2double(get(data.edit5, 'String'));
h_uipanel12 = get(data.uipanel12, 'SelectedObject');
methodName = get(h_uipanel12, 'String');
switch methodName
    case 'PCA'
        pca_train(trainInfo, newSize, m1);
        train_file = '.\pca_data.mat';
    case 'LDA'
        lda_train(trainInfo, newSize, m2);
         train_file = '.\lda_data.mat';
    case 'MPCA'
        mpca_train(trainInfo, newSize, p);
        train_file = '.\mpca_data.mat';
    case 'PCA+LDA'
        pca_lda_train(trainInfo, newSize, m1, m2);
        train_file = '.\pca_lda_data.mat';
    case 'MPCA+LDA'
        mpca_lda_train(trainInfo, newSize, p);
        train_file = '.\mpca_lda_data.mat';
end
set(data.text_state, 'String', ['使用', methodName, '训练完成，数据保存至',train_file, ' ！']);


% newSize edit 创建的回调函数
function edit8_CreateFcn(h, eventdata, data)
if ispc && isequal(get(h,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(h,'BackgroundColor','white');
end
set(h, 'String', '15,15');


% 识别指定图片按钮回调函数
function pushbutton10_Callback(h, eventdata, data)
[filename, path] = uigetfile('*');
imgName1 = [path, filesep, filename];
imgName{1} = imgName1; 
h_uipanel12 = get(data.uipanel12, 'SelectedObject');
methodName = get(h_uipanel12, 'String');
switch methodName
    case 'PCA'
        [test_label, rate] = pca_test('', imgName, @eulerDis);
    case 'LDA'
        [test_label, rate] = lda_test('', imgName, @eulerDis);
    case 'MPCA'
        [test_label, rate] = mpca_test('', imgName, @eulerDis);
    case 'PCA+LDA'
        [test_label, rate] = pca_lda_test('', imgName, @eulerDis);
    case 'MPCA+LDA'
        [test_label, rate] = mpca_lda_test('', imgName, @eulerDis);
end
set(data.text_state, 'String', ['使用', methodName, '对 ', imgName{1}, ' 进行识别，识别结果是：', test_label{1}]);
load('trainInfo.mat');
for i=1:trainInfo.N
    if strcmp(trainInfo.label_list{i}, test_label{1})
        imgName2 = trainInfo.name_list{i};
        break;
    end
end
img1 = imread(imgName1);
[h1, w1, ~] = size(img1);
img2 = imread(imgName2);
[h2, w2, ~] = size(img2);
h = min([h1;h2]);
w = min([w1;w2]);
img1 = imresize(img1,[h, w]);
img2 = imresize(img2,[h, w]);
axes(data.axes1);
imshow([img1,img2]);
title('待识别图片（左）与从人脸库中识别出的结果（右）','fontsize',8);


% 状态显示 edit 析构的回调函数
function text_state_DeleteFcn(h, eventdata, data)
rmpath('..\face_detection');
rmpath('..\common');
rmpath('..\face_recognition\PCA');
rmpath('..\face_recognition\LDA');
rmpath('..\face_recognition\PCA_LDA');
rmpath('..\face_recognition\MPCA');
rmpath('..\face_recognition\MPCA_LDA');


function edit9_CreateFcn(h, eventdata, data)
if ispc && isequal(get(h,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(h,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function pushbutton18_Callback(hObject, eventdata, handles)



function pushbutton19_Callback(hObject, eventdata, handles)



function uipanel12_SelectionChangeFcn(hObject, eventdata, handles)
h = get(handles.uipanel12, 'selectedobject');
str = get(h, 'string');
switch str
    case 'PCA'
        set(handles.edit8, 'string', '15,15');
    case 'LDA'
        set(handles.edit8, 'string', '10,10');
    case 'MPCA'
        set(handles.edit8, 'string', '15,15');
    case 'PCA+LDA'
        set(handles.edit8, 'string', '10,10');
    case 'MPCA+LDA'
        set(handles.edit8, 'string', '15,15');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

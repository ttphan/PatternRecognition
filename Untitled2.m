
%% Data creation
a = prnist([0:9], [1:200:1000]);
b = im_box(a, [], 1);
c = im_resize(b, [32, 32]);
[train,test] = gendat(c,0.8);
train = train*datasetm;
test = test*datasetm;

%% contour OR
b = train;
area = im_stat(b, 'sum');
bx = abs(filtim(b, 'conv2', {[-1 1], 'same'}));
by = abs(filtim(b, 'conv2', {[-1 1]', 'same'}));
bor = or(bx,by);

%% next step
perimeter = im_stat(bor, 'sum');
%% fuckzooi
c = prdataset([area perimeter]);
c = setprior(c,0);
c = setfeatlab(c,char('area','perimeter'));

%% figure
figure;
scatterd(c, 'legend');

%% train
w = ldc(c);
plotc(w, 'col');
showfigs
function [robot,serial] = initializer()


% Link(DH, OPTIONS) is a link object using the specified kinematic
% convention  and with parameters:
%  - DH = [THETA D A ALPHA SIGMA OFFSET] where SIGMA=0 for a revolute and 1
%    for a prismatic joint; and OFFSET is a constant displacement between the
%    user joint variable and the value used by the kinematic model.
%  - DH = [THETA D A ALPHA SIGMA] where OFFSET is zero.
%  - DH = [THETA D A ALPHA], joint is assumed revolute and OFFSET is zero.
%Options::
%
% 'standard'    for standard D&H parameters (default).
% 'modified'    for modified D&H parameters.
% 'revolute'    for a revolute joint, can be abbreviated to 'r' (default)
% 'prismatic'   for a prismatic joint, can be abbreviated to 'p'


[DH mdh]=dh_params();

L(1)=Link(DH(1,1:6), mdh);
L(2)=Link(DH(2,1:6), mdh);
L(3)=Link(DH(3,1:6), mdh);
L(4)=Link(DH(4,1:6), mdh);
L(5)=Link(DH(5,1:6), mdh);

robot=cork2mine(DH,3,mdh);


serial= SerialLink(L);
homo=homo_mat(robot);
homo=homo(:,:,6);
homo=subs(homo,"t6",pi/2);
homo=double(homo);
serial.tool=SE3(homo);



end




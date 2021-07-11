%%  OSOS
%   OLYMPUS Slide-Scanner Output Sorter
%
%   Organizes the outputs that come from converting VSI files to TIF files
%   when exporting images from an OLYMPUS slide scanning microscope
%
%   Developped using outputs from an OLYMPUS VS120
%
%
%   OSOS.m is a function for the sorting of TIF files following VSI
%   conversion of OLYMPUS Slide Scanner Outputs
%   Copyright (C) 2021 Dylan Terstege
%
%   This program is free software; you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License , or (at your
%   option) any later version.
%
%   This program is distributed in the hope that it will be useful, but
%   WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%   General Public License for more details.
%
%   You should have received a copy of the GNU General Public License along
%   with this program.  If not, see <https://www.gnu.org/licenses/>.
%
%   Created 07/11/2021 Dylan Terstege (https://github.com/dterstege)
%   Epp Lab, University of Calgary (https://epplab.com)
%   Contact: dylan.terstege@ucalgary.ca

in_dir=uigetdir('Select the parent folder containing all exported images');
cd(in_dir);
folders=dir('*.vsi.Collection');
for jj=1:2  %the number of channels
    cd(in_dir);
    chnum=strcat('CH',num2str(jj-1));
    mkdir(chnum);
for ii=1:length(folders)
    cd(in_dir);
    slideFolders=dir(folders(ii).name);
    for iii=3:(numel(slideFolders)-1)
        slideFoldDir=strcat(folders(ii).folder,'/',folders(ii).name,'/');
        cd(slideFoldDir);
        subFold=strcat(slideFolders(iii).folder,'/',slideFolders(iii).name,'/');
        cd(subFold);
        chtif=strcat('CH',num2str(jj-1),'.tif');
        if isfile(chtif)
            lastDigit=str2double(regexp(slideFolders(iii).name,'\d*','match'));
            folderName=strsplit(folders(ii).name,'.');
            folderName=folderName(1);
            newName=strcat(char(folderName),'_',num2str(lastDigit,'%02.f'),'.tif');
            movefile(chtif,newName);
            movefile(newName,strcat(in_dir,'/',chnum));
        else
            %let it loop
        end
    end
end
end
        
        
        
        
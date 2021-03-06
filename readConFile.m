function readConFile = readConFile(filePath, delay)

readData = readtable(filePath);
var = readData.Properties.VariableNames;
data = readData;

fileSize = size(data);

mainOutputText = [];

ph = 1.14e-5;

for ii=var
    OutputText = '';
    for iterate = 1:fileSize(1)
        currentPosition = iterate;
        if iterate > delay && ( string(ii(1)) == 'value')
            conValueString = data.(ii{1})(currentPosition:currentPosition);
            conValue = double(conValueString);
            goalValue = (conValue + (currentPosition/60)- ph) * 10000;
            %goalValue = J * (((valueK * valueL)+ ((valueM/valueK) * N)) ); 
            OutputText = strcat(OutputText, ' S/No= ');
            OutputText = strcat(OutputText, num2str(iterate));
            OutputText = strcat(OutputText, ' CON= ');
            OutputText = strcat(OutputText, num2str(conValue));
            OutputText = strcat(OutputText, ' VALUE= ');
            OutputText = strcat(OutputText, num2str(goalValue));
            OutputText = strcat(OutputText, '___');
            output = string({'CON : ' conValue ' Conductivity Calibrated By PH : ' goalValue}); 
            disp(output);
            WriteLog(output);
            mainOutputText = cat(1,mainOutputText ,string({goalValue}));
        elseif iterate <= delay && ( string(ii(1)) == 'value')
            conValueString = data.(ii{1})(currentPosition:currentPosition);
            conValue = double(conValueString);
           	OutputText = strcat(OutputText, ' S/No= ');
            OutputText = strcat(OutputText, num2str(iterate));
            OutputText = strcat(OutputText, ' CON= ');
            OutputText = strcat(OutputText, num2str(conValue));
            OutputText = strcat(OutputText, ' VALUE= ');
            OutputText = strcat(OutputText, 'SKIPPED');
            OutputText = strcat(OutputText, '___');
            disp(string({'Skipping : ' iterate '->' data.(ii{1})(iterate:iterate)})) 
        end
    end
end

fid=fopen('tmp\conductivity_calculation.csv','w');
for index = 1:size(mainOutputText)
    fprintf(fid, '%i,%s \n', index , mainOutputText{index} );
end
fclose(fid);

readConFile = mainOutputText;


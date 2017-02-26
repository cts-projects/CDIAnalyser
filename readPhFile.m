function readPhFile = readPhFile(filePath, delay)

readData = readtable(filePath);
var = readData.Properties.VariableNames;
data = readData;

fileSize = size(data);

valueM = 0.0000000000001; % ???

e= 1.602e-19;

kB= 1.38e-23;

T= 298;

H = 9.30e-9;

NA= 6.02e23;

multi= e*NA;

J = (e^2)/(kB * T);

valueL = NA * 1000 * H;

OH = 5.30e-9;

N = NA * 1000 * OH;

mainOutputText = '';


for ii=var
    OutputText = '';
    for iterate = 1:fileSize(1)
        currentPosition = iterate;
        if iterate > delay && ( string(ii(1)) == 'pH')
            phValueString = data.(ii{1})(currentPosition:currentPosition);
            phValue = double(phValueString);
            valueK = 10^(-phValue -(currentPosition/60));
            goalValue = J * (((valueK * valueL)+ ((valueM/valueK) * N)) ); 
            OutputText = strcat(OutputText, ' S/No= ');
            OutputText = strcat(OutputText, num2str(iterate));
            OutputText = strcat(OutputText, ' PH= ');
            OutputText = strcat(OutputText, num2str(phValue));
            OutputText = strcat(OutputText, ' VALUE= ');
            OutputText = strcat(OutputText, num2str(goalValue));
            OutputText = strcat(OutputText, '___');
            disp(   string({'PH : ' phValue ' Output : ' goalValue}));
        elseif iterate <= delay && ( string(ii(1)) == 'value')
            phValueString = data.(ii{1})(currentPosition:currentPosition);
            phValue = double(phValueString);
           	OutputText = strcat(OutputText, ' S/No= ');
            OutputText = strcat(OutputText, num2str(iterate));
            OutputText = strcat(OutputText, ' PH= ');
            OutputText = strcat(OutputText, num2str(phValue));
            OutputText = strcat(OutputText, ' VALUE= ');
            OutputText = strcat(OutputText, 'SKIPPED');
            OutputText = strcat(OutputText, '___');
            disp(string({'Skipping : ' iterate '->' data.(ii{1})(iterate:iterate)})) 
        end
    end
    mainOutputText = strcat(mainOutputText,OutputText);
end
readPhFile = mainOutputText;


function res = nsnan(TaskIDName, splitRes)
%NSNAN Does some basic data transformation to all noise/signal-noise tasks.
%
%   Basically, the supported tasks are as follows:
%     1. Symbol
%     2. Orthograph
%     3. Tone
%     4. Pinyin
%     5. Lexic
%     6. Semantic
%   The output table contains 8 variables, called Count_hit, Count_FA,
%   Count_miss, Count_CR, RT_hit, RT_FA, RT_miss, RT_CR

%By Zhang, Liang. 04/13/2016. E-mail:psychelzh@gmail.com

%chkVar is used to check outliers.
chkVar = {};
%coupleVars are formatted out variables.
varPref = {'Rate', 'RT'};
varSuff = {'Overall', 'hit', 'FA'};
delimiter = '_';
coupleVars = strcat(repmat(varPref, 1, length(varSuff)), delimiter, repelem(varSuff, 1, length(varPref)));
%further required variables.
singletonVars = {'dprime', 'c'};
%Out variables names are composed by three part.
outvars = [chkVar, coupleVars, singletonVars];
if ~istable(splitRes{:}) || isempty(splitRes{:})
    res = {array2table(nan(1, length(outvars)), ...
        'VariableNames', outvars)};
    return
end
RECORD = splitRes{:}.RECORD{:};
%Cutoff RTs: for too fast trials.
RECORD(RECORD.RT < 100 & RECORD.RT > 0, :) = [];
%Remove NaN trials.
RECORD(isnan(RECORD.ACC), :) = [];
%Modify SCat.
langTask = {'Symbol', 'Orthograph', 'Tone', 'Pinyin', 'Lexic', 'Semantic'};
GNGTask = {'DRT', 'GNGLure', 'GNGFruit'};
switch TaskIDName{:}
    case langTask
        switch TaskIDName{:}
            case 'Symbol'
                CResp = cell2table(...
                    [repmat({'��', 0; '��', 0; '��', 0; '��', 0; '��', 0}, 5, 1); ...
                    repmat({'��', 1}, 25, 1)], ...
                    'VariableNames', {'STIM', 'SCat'});
            case 'Orthograph'
                %When STIM <= 25, SCat -> 1.
                CResp = cell2table(...
                    [cellfun(@num2str, num2cell((1:50)'), 'UniformOutput', false), ...
                    num2cell([ones(25, 1); zeros(25, 1)])], ...
                    'VariableNames', {'STIM', 'SCat'});
            case 'Tone'
                CResp = cell2table(...
                    {'��',1;'��',1;'��',1;'��',1;'��',1;'��',1;'��',1;'��',1;'��',1;...
                    '��',1;'��',1;'��',1;'ȥ',1;'��',1;'Ū',1;'��',1;'��',1;'��',1;'��',1;...
                    'У',1;'��',1;'��',1;'��',1;'��',1;'��',1;'��',0;'��',0;'��',0;'��',0;...
                    '��',0;'��',0;'��',0;'��',0;'��',0;'��',0;'��',0;'��',0;'ϰ',0;'��',0;...
                    '��',0;'��',0;'ƽ',0;'��',0;'��',0;'��',0;'��',0;'��',0;'��',0;'Ʒ',0;'��',0;}, ...
                    'VariableNames', {'STIM', 'SCat'});
            case 'Pinyin'
                CResp = cell2table(...
                    {'��uh',0;'m��in',0;'b��g',0;'l��',1;'r��n��',1;'dlu��',0;'x��n��',1;...
                    'c��n��',1;'hu��',1;'hs��',0;'��u��n��',1;'w��in',0;'y��',1;'b��g',0;'h��u',1;...
                    'u��n',0;'bi��',0;'x��n��',1;'zh��n',1;'j��in',0;'ti��n',1;'qi��',1;'li��m',0;...
                    'm��io',0;'ji��n',1;'si��n',0;'m��o',1;'fi��n',0;'ni��g',0;'j��nq',0;'w��i',1;...
                    'x��ng',0;'ti��n',1;'n��l',0;'xii��',0;'w��',1;'sh��n��',1;'p��i',1;'bo��',0;...
                    'd��u',1;'d��n',0;'po��',0;'i��n',0;'ch��',1;'bi��n',1;'l��m',0;'zh����',0;...
                    'y��',1;'xu��',1;'sh��o',1}, ...
                    'VariableNames', {'STIM', 'SCat'});
            case 'Lexic'
                CResp = cell2table(...
                    {'�ݵ�',1;'����',1;'��԰',1;'��Щ',1;'�߹�',1;'�ܲ�',1;'����',1;...
                    'Զ��',1;'����',1;'��ɫ',1;'����',1;'��ҵ',1;'��Ұ',1;'����',1;'����',1;...
                    'Ư��',1;'ͬѧ',1;'����',1;'����',1;'����',1;'�ش�',1;'����',1;'��ɫ',1;...
                    '����',1;'����',1;'�λ�',0;'����',0;'ƽ��',0;'����',0;'����',0;'վʿ',0;...
                    '����',0;'ʯ��',0;'ֹͤ',0;'����',0;'����',0;'�Ϲ�',0;'����',0;'����',0;...
                    '����',0;'����',0;'�޲�',0;'����',0;'����',0;'����',0;'����',0;'����',0;...
                    '����',0;'����',0;'����',0;}, ...
                    'VariableNames', {'STIM', 'SCat'});
            case 'Semantic'
                CResp = cell2table(...
                    {'����',1;'����',1;'����',1;'ˮţ',1;'����',1;'ɽ��',1;'�ڹ�',1;...
                    '��è',1;'��ţ',1;'����',1;'ҰѼ',1;'�ϻ�',1;'����',1;'����',1;'����',1;...
                    'ʨ��',1;'�ڹ�',1;'��ѻ',1;'���',1;'����',1;'��ȸ',1;'����',1;'��Ÿ',1;...
                    '֩��',1;'�ڻ�',1;'����',0;'����',0;'����',0;'��',0;'�ɻ�',0;'��ɽ',0;...
                    '����',0;'�輸',0;'����',0;'����',0;'����',0;'��',0;'Ƥ��',0;'�̳�',0;...
                    '����',0;'�ܲ�',0;'�糿',0;'����',0;'ľ��',0;'ë��',0;'�ؿ�',0;'��ɡ',0;...
                    'ɳ��',0;'β��',0;'ѩ��',0;}, ...
                    'VariableNames', {'STIM', 'SCat'});
        end
        [~, locSTIM] = ismember(RECORD.STIM, CResp.STIM);
        if any(locSTIM == 0)
            warning('Certain stimluli not defined in correct answer table. Quiting.\n');
            res = {array2table(nan(1, 8), ...
                'VariableNames', outvars)};
            return
        end
        %SCat: 1. Denote to respond with 'yes', 2. Denote to repond with 'no'.
        RECORD.SCat = CResp.SCat(locSTIM);
    case GNGTask
        switch TaskIDName{:}
            case 'DRT'
                %Find out the no-go stimulus.
                if ~iscell(RECORD.STIM)
                    RECORD.STIM = num2cell(RECORD.STIM);
                end
                allSTIM = unique(RECORD.STIM(~isnan(RECORD.ACC)));
                firstTrial = RECORD(1, :);
                firstIsGo = firstTrial.ACC == 1 && firstTrial.RT < 3000;
                if firstIsGo
                    NGSTIM = allSTIM(~ismember(allSTIM, firstTrial.STIM));
                else
                    NGSTIM = firstTrial.STIM;
                end
            case {'GNGLure', 'GNGFruit'}
                switch TaskIDName{:}
                    case 'GNGLure'
                        %0-3, 10-11 -> NoGo
                        NGSTIM = [0:3, 10:11];
                    case 'GNGFruit'
                        %0 -> NoGo
                        NGSTIM = 0;
                end
                %ACC variable is not correctly recorded, rectify it here.
                %If the RT is 2000(for GNGLure) or 0 (for GNGFruit), we
                %interpret it as no response.
                RECORD.ACC(ismember(RECORD.STIM, NGSTIM)) = ...
                    RECORD.RT(ismember(RECORD.STIM, NGSTIM)) == 2000 | ...
                    RECORD.RT(ismember(RECORD.STIM, NGSTIM)) == 0;
        end
        %SCat: 1. Denote 'go' trial, 2. Denote 'no-go' trial.
        RECORD.SCat = ~ismember(RECORD.STIM, NGSTIM);
end
%ACCuracy and MRT.
Rate_Overall = mean(RECORD.ACC); %Rate is used in consideration of consistency.
RT_Overall = mean(RECORD.RT(RECORD.ACC == 1));
%Ratio of hit and false alarm.
Rate_hit = mean(RECORD.ACC(RECORD.SCat == 1));
Rate_FA = mean(~RECORD.ACC(RECORD.SCat == 0));
%Mean RT computation.
RT_hit = nanmean(RECORD.RT(RECORD.SCat == 1 & RECORD.ACC == 1));
RT_FA = nanmean(RECORD.RT(RECORD.SCat == 0 & RECORD.ACC == 0));
%d' and c.
[dprime, c] = sngdetect(Rate_hit, Rate_FA);
res = {table(Rate_Overall, RT_Overall, Rate_hit, Rate_FA, RT_hit, RT_FA, dprime, c)};

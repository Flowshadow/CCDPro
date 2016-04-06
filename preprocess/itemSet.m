function setting = itemSet(sheets)
%Do items setting.

variables = cell(size(sheets));
QID = nan(size(sheets));
Alternative = zeros(size(sheets));
anafuncs = cell(size(sheets));
anavars = cell(size(sheets));
cates = zeros(size(sheets));
nSheets = length(sheets);
for i = 1:nSheets
    initialVars = who;
    %For the preprocessing step.
    switch sheets{i}
        case {...
                '���ټ���', ...
                '����ʦ', ...
                }
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'RT', 'ACC', 'score'};
            questID = 12;
        case '˼άת��'
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'score'};
            questID = 1;
        case '��ϵ����'
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'score'};
            questID = 2;
        case { ...
                '�����ջ�' ...
                'ˮ������', ...
                }
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'RT', 'ACC', 'score'};
            questID = 3;
        case {...
                '��Ӧ�ٶ� ��ͯ��(����)', ...
                '�ֱ��ٶȶ�ͯ��(�������ҡ�̫��������)', ...
                'ѡ���ٶȶ�ͯ�棨��������̫�����ң�', ...
                '�ֱ��ٶ�(��ɫ���ҡ���ɫ������)', ...
                'ѡ���ٶ�', ...
                '�ֱ��ٶ�(��ɫ���󣬺�ɫ������)', ...
                '��Ӧ�ٶȣ���ɫ��', ...
                '��Ӧ�ٶȶ�ͯ�棨̫����', ...
                '�ֱ��ٶȶ�ͯ��(̫�����ҡ�����������)',...
                }
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'RT', 'ACC', 'score'};
            questID = 8;
        case '�������'
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'score'};
            questID = 9;
        case '׽��'
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'score'};
            questID = 19;
        case {...
                '˳����', ...
                '������', ...
                }
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'score'};
            questID = 10; % An alternative choice of question ID.
            Alt = 14;
        case {...
                '˳������', ...
                '��������', ...
                }
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'score'};
            questID = 14;
        case { ...
                '����ħ��ʦ����', ...
                '����ħ��ʦ�м�', ...
                }
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'RT', 'ACC', 'score'};
            questID = 4;
        case {...
                '����ע�����', ...
                '����ע���м�', ...
                }
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecordl', 'qrecordr', 'score'};
            questID = 15;
            Alt = 11;
        case {...
                'ͼƬ����', ...
                '�������', ...
                }
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'score'};
            questID = 16;
        case '�������'
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecordlearn', 'qrecordtest', 'score'};
            questID = 17;
            Alt = 18;
        case '�������'
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'RT', 'ACC', 'score'};
            questID = 5;
        case '�����ʦ'
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'RT', 'ACC', 'score'};
            questID = 6;
        case '��Ӧ�ٶȣ���ɫ��'
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'score'};
            questID = 8;
        case 'λ�ü���'
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'score'};
            questID = 13;
        case {...
                '��ɫ���ˣ����壩', ...
                '��ɫ���ˣ���ɫ��', ...
                }
            Vars = {'uuid', 'pid', 'name', 'gender', 'school', 'grade', 'qrecord', 'RT', 'ACC', 'score', 'sdk'};
            questID = 7;
    end
    if ~exist('Alt', 'var')
        Alt = 0;
    end
    variables{i} = Vars;
    QID(i) = questID;
    Alternative(i) = Alt;
    anafuncs{i} = anafunc;
    anavars{i} = anavar;
    cates(i) = cate;
    clearvars('-except', initialVars{:})
end
setting = table(sheets, variables, QID, Alternative, anafuncs, anavars, cates);
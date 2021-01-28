import glob
import os
from csv import reader


for i in glob.glob('../behavior/EVfiles/*'):
    sub_number = i[20:24]
    print(sub_number)
    with open('test_output.csv', 'r') as read_obj:
        csv_reader = reader(read_obj)
        # Iterate over each row in the csv using reader object
        for row in csv_reader:
            if sub_number == row[0][:4]:
                trial_type = row[0][-1:]
                nvols = row[2]
                condition = row[0][5:11]
                condition = condition.replace("_", "").capitalize()
                print(trial_type, nvols, condition)
                os.system(f'./models/L1_task-sr{condition}{trial_type}\_\model-01.sh {sub_number} 2 0 6 {nvols}')
                os.system(f'./models/L1_task-sr{condition}{trial_type}\_\model-01.sh {sub_number} 2 0 6 {nvols}')
        read_obj.close()

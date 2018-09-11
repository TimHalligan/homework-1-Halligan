
import csv
import os
file = 'c:/LearnPython/budget_data.csv'

Row_Count = 0
Change = 0
Total_Value = 0
Max_index_Number = 0
Min_index_Number = 0
Max_Date = 0
Min_Date = 0
Date = 0
Date_List = []
Change_List = []
Change_List_Unsorted = []

with open(file, newline="") as csvfile:
    csvreader = csv.reader(csvfile,delimiter=",")
    next(csvreader)                                     # Advance past Heder to start for loop

    for row in csvreader:                               # Loop through all data rows
        if (Row_Count == 0):                            # If first line of data then:
            Previous_Month = int(row[1])                # Profit/Loss $amt in first row of data assigned to "Previous_Month" variable (stored for next row "Change" calc)
            Total_Value = Previous_Month                # Start "Total_Value" accummulation with this first row $amt (named "Previous_Month")
            Date = row[0]                               # Assign current row date to "Date"
            Date_List.append(Date)                      # Add "Date" to "Date_List"
        else:                                           # All rows after first row:
            Current_Month = int(row[1])                 # Profit/Loss $amt is assigned to "Current month" variable
            Change = Current_Month - Previous_Month     # The Profit/Loss "Change" variable is estblished as the current row $amt less "Previous_Month" $amt
            Total_Value = Total_Value + Current_Month   # After establishing the Total_Value = to the first row, add current raw each cycle through
            Previous_Month = Current_Month              # After calculating the "Change" for the current row, the current row becomes "Previous Month" (stored for next row "Change" calc)
            Change_List.append(Change)                  # add current month "Change" to "Change_List"
            Change_List_Unsorted.append(Change)         # add current month "Change" to "Change_list_Unsorted" - needed in order to determine indexes for dates
            Date = row[0]                               # Assign current row date to "Date"
            Date_List.append(Date)                      # Add "Date" to "Date_List"
        Row_Count += 1                                  # "Row_Count" accumulator

Change_List.sort()                                      # Sort "Change_List" to be able to determing "Min" and "Max"
Min = Change_List[0]                                    # Minimum "Change" = First value in sorted "Change_List"
Max = Change_List[-1]                                   # Maximum "Change" = Last value in sorted "Change_List"

for i in range(len(Change_List_Unsorted)):              # Determine the index number of the "Min" - to be used to determine Min_Date
  if Change_List_Unsorted[i] == Min:
        Min_index_Number = i
        break
for i in range(len(Change_List_Unsorted)):              # Determine the index number of the "Max" - to be used to determine Max_Date
  if Change_List_Unsorted[i] == Max:
        Max_index_Number = i
        break

Min_Date = Date_List[Min_index_Number +1 ]              # Min_Date - index should be the index of "Min Change" +1 ("Change" starts one row later)
Max_Date = Date_List[Max_index_Number +1 ]              # Max Date - index should be the index of "Max Change" +1 ("Change" starts one row later)

Average_Change = sum(Change_List) / (len(Change_List))

Summary = (f'Final Analysis\
         \n---------------------------------------------------\
         \nTotal Month: {Row_Count}\
         \nTotal: ${Total_Value}\
         \nAverage Change: ${round((Average_Change),2)}\
         \nGreatest Increase in Profits: {Max_Date} (${Max})\
         \nGreatest Decrease in Profits: {Min_Date} (${Min})')

print(Summary)

# Set variable for output file
output_file = open('PyBank','w')
output_file.write(Summary)
output_file.close()

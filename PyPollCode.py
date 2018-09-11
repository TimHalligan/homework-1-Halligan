import csv

file = 'c:/LearnPython/election_data.csv'

Row_Count = 0

Li = []                                                         # Establish Lists to collect votes
Correy = []
Khan = []
OTooley =[]

Counts = []                                                     # List to collect total counts of each canidate

with open(file, newline="") as csvfile:
    csvreader = csv.reader(csvfile,delimiter=",")
    next(csvreader)

    for row in csvreader:                                       # Cycle thru all rows and append list based on name
        Name = row[2]
        if (row[2] == "Li"):
            Li.append(Name)
        elif (row[2] == "Correy"):
            Correy.append(Name)
        elif (row[2] == "Khan"):
            Khan.append(Name)
        elif (row[2] == "O'Tooley"):
            OTooley.append(Name)
        Row_Count += 1                                          # Accumulate total count #

    Win = ''                                                    # Establish variable for winner names - (all four could tie)
    Win2 = ''
    Win3 = ''
    Win4 = ''

    Counts = [len(Khan),len(Li),len(Correy),len(OTooley)]       # list of number of votes for each canidate
    Counts.sort()                                               # Sort list to determine most votes
    Most = (Counts[-1])                                         # Most = last number in the sorted list

    if len(Khan) == Most:                                       # Determing who has the most votes
        Win = 'Khan'
    else: Win = ''
    if len(Li) == Most:
        Win2 = 'Li'
    else: Win2 = ''
    if len(Correy) == Most:
        Win3 = 'Khan'
    else: Win3 = ''
    if len(OTooley) == Most:
        Win4 = 'OTooley'
    else: Win4 = ''

    Khan_Percent = ((len(Khan) / Row_Count))*100                # Determine canidates vote %
    Li_Percent = (len(Li) / Row_Count)*100
    Correy_Percent = (len(Correy) / Row_Count)*100
    OTooley_Percent = (len(OTooley) / Row_Count)*100

    Summary = (f'Election Results\
              \n---------------------------------------------------------------------\
              \nTotal Votes: {Row_Count}\
              \n---------------------------------------------------------------------\
              \nKhan: {"{0:.3f}".format(Khan_Percent)}% ({len(Khan)})\
              \nCorrey: {"{0:.3f}".format(Correy_Percent)}% ({len(Li)})\
              \nLi: {"{0:.3f}".format(Li_Percent)}% ({len(Correy)})\
              \nOTooley: {"{0:.3f}".format(OTooley_Percent)}% ({len(OTooley)})\
              \n---------------------------------------------------------------------\
              \nWinner(s): {Win} {Win2} {Win3} {Win4}\
              \n---------------------------------------------------------------------')

    print(Summary)

output_file = open('PyPoll','w')
output_file.write(Summary)
output_file.close()

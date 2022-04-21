from functions import sw_funcs, google_funcs
import pandas as pd
from splitwise import Splitwise
from splitwise.expense import Expense
from splitwise.expense import ExpenseUser

s = sw_funcs.sw_connect_api()
#
#person_one = sw_funcs.sw_current_user(s)
#person_two = sw_funcs.sw_other_user(s,"Grace", "Williams")
group_id = sw_funcs.sw_group_id(s,"Everyday spEnding")

df = pd.read_csv("../update_expenses.csv")

for ind in df.index:
    print(df["exp_id"][ind])
    expense = Expense()
    expense.id = df["exp_id"][ind]
    #print(expense.getDescription())
    #expense.category_id
    #expense.setCost('10')
    if pd.isnull(df["new_desc"][ind]):
        pass
    else:
        expense.setDescription(df["new_desc"][ind])

    if pd.isnull(df["final_new_cat_id"][ind]):
        pass
    else:
        expense.category_id = (df["final_new_cat_id"][ind])
    #expense.category_id = cat_id

    s.updateExpense(expense)



#
#expense = Expense()
#expense.id = 1391393142
#print(expense.getDescription())
##expense.setCost('10')
#expense.setDescription("Car Dodge Journey big.")
##expense.category_id = cat_id
#
#s.updateExpense(expense)
#
#update = s.getExpense(1391393142)
#print(update.getDescription())
#

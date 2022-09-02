
import tkinter as tk


# creating window
window = tk.Tk()
 
# setting attribute
window.state('zoomed')
window.title("Full window")
 
# creating text label to display on window screen
label = tk.Label(window, text="Hello world!")
label.pack()
 
window.mainloop()

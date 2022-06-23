from i3ipc import Connection, Event

# Create the Connection object that can be used to send commands and subscribe
# to events.
i3 = Connection()

# Define a callback to be called when you switch workspaces.
def on_workspace_focus(self, e):
    # # The first parameter is the connection to the ipc and the second is an object
    # # with the data of the event sent from i3.
    # if e.current:
    #     print('Windows on this workspace:')
    #     for w in e.current.leaves():
    #         print(w.name)
    pass

# Dynamically name your workspaces after the current window class
def on_window_focus(i3, e):
    focused = i3.get_tree().find_focused()
    print('focused', focused.window_class)
    # ws_name = "%s:%s" % (focused.workspace().num, focused.window_class)
    # i3.command('rename workspace to "%s"' % (focused.workspace().num))

def on_new_window(i3, e):
    print(e.ipc_data)
    instance = e.ipc_data['container']['window_properties']['instance']
    title = e.ipc_data['container']['window_properties']['title']
    print(e.change, f'{title=} {instance=}')

# Subscribe to events
#i3.on(Event.WORKSPACE_FOCUS, on_workspace_focus)
i3.on(Event.WINDOW_NEW, on_new_window)

# Start the main loop and wait for events to come in.
i3.main()

"""
LICENCE POPUP SIGNATURE
{'change': 'new', 'container': {'id': 94487396854368, 'type': 'con', 'orientation': 'none', 'scratchpad_state': 'none', 'percent': 1.0, 'urgent': False, 'marks': [], 'focused': False, 'output': 'eDP1', 'layout': 'splith', 'workspace_layout': 'default', 'last_split_layout': 'splith', 'border': 'normal', 'current_border_width': 2, 'rect': {'x': 396, 'y': 273, 'width': 574, 'height': 180}, 'deco_rect': {'x': 0, 'y': 0, 'width': 574, 'height': 20}, 'window_rect': {'x': 2, 'y': 0, 'width': 570, 'height': 178}, 'geometry': {'x': 0, 'y': 0, 'width': 570, 'height': 178}, 'name': None, 'window_icon_padding': -1, 'window': 130495058, 'window_type': 'dialog', 'window_properties': {'class': 'Subl3', 'instance': 'subl3', 'machine': 'fr-lefuturiste-laptop', 'transient_for': None}, 'nodes': [], 'floating_nodes': [], 'focus': [], 'fullscreen_mode': 0, 'sticky': False, 'floating': 'auto_on', 'swallows': []}}
"""
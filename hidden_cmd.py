'''
run a line of command and get its return without outputing on displayer
'''
import subprocess

def hidden_command(command, code = 'utf-8'):
    p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, 
                           stderr=subprocess.PIPE, close_fds=True)
    output_byte_line_list = p.stdout.readlines()
    output = ''.join([line.decode(code) for line in output_byte_line_list])
    return output

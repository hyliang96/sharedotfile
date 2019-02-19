'''
run a line of command and get its return without outputing on displayer
'''
import subprocess

def hidden_command(command, code = 'utf-8'):
    # command += ' 2>&1'
    command = command.encode(code)
    p = subprocess.Popen(
        command, shell=True, stdout=subprocess.PIPE,
        stderr=subprocess.PIPE, close_fds=True)

    output_byte_line_list = p.stdout.readlines()

    output = ''.join([
            line.decode(code)
            for line in output_byte_line_list
        ])
    if len(output)>0 and output[-1]=='\n':
        output = output[:-1]
    return output

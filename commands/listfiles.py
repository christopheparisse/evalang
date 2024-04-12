import sys, os, getopt

def help():
    print('List the files in the argument of the command')
    print("listfiles.py -o output_file -e extension ...(list of files or folders)")

def main(args):
    if len(args) > 1:
        optlist, arguments = getopt.gnu_getopt(args, 'ho:e:', ['help', 'output=', 'extension='])
        print(arguments)
        print(optlist)
        extension = '.txt'
        for oarg in optlist:
            if oarg[0] == '-h' or oarg[0] == '--help':
                help()
            if oarg[0] == '-o' or oarg[0] == '--output':
                output_folder_file = oarg[1]
            if oarg[0] == '-e' or oarg[0] == '--extension':
                extension = oarg[1]
        input_folder_files = arguments[1:]
        file_paths = []
        for iff in input_folder_files:
            if (os.path.isfile(iff)):
                file_paths.append(iff)
            else:
                for (dir_path, dir_names, file_names) in os.walk(iff):
                    for file_name in file_names:
                        if file_name.endswith(extension):
                            file_paths.append(dir_path + '/' + file_name)
        file_paths.sort()
        for f in file_paths:
            print(f)


if __name__ == "__main__":
    main(sys.argv)

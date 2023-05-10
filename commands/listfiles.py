import sys, os, getopt

def main(args):
    if len(sys.argv) > 1:
        optlist, arguments = getopt.gnu_getopt(sys.argv, '', [])
        input_folder_files = arguments[1:]
        file_paths = []
        for iff in input_folder_files:
            if (os.path.isfile(iff)):
                file_paths.append(iff)
            else:
                for (dir_path, dir_names, file_names) in os.walk(iff):
                    for file_name in file_names:
                        if (file_name.endswith('.txt')):
                            file_paths.append(dir_path + '/' + file_name)
        file_paths.sort()
        for f in file_paths:
            print(f)

if __name__ == "__main__":
    main(sys.argv[1:])

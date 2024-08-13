import sys

def process_file(input_file, output_file, X, Y):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        lines = infile.readlines()
        for i in range(len(lines)):
            line = lines[i]
            # Check if the line contains the string X
            if X in line:
                # Extract the substring A (you can define how to extract A)
                start_idx = 11
                end_idx = line.find(' && cd ./')
                A = line[start_idx:end_idx]
                # print(A)
                # Check if there is a next line
                if i + 1 < len(lines):
                    next_line = lines[i + 1]
                    # Replace Y with A in the next line
                    next_line = next_line.replace(Y, 'champsimtrace.xz > ' + A + '.out 2>&1 &')
                    lines[i + 1] = next_line

            # Write the processed line to the output file
            outfile.write(line)

# Example usage
input_file = sys.argv[1]
output_file = sys.argv[2]
X = 'mkdir -p ./'  # The string to search for in the current line
Y = 'champsimtrace.xz  &'  # The substring to replace in the next line

process_file(input_file, output_file, X, Y)
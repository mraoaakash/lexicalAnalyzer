# LexicalAnalyzer
In this repository we create a lexical analyzer that works to analyze nanoC and convert it into a token stream. THis is part of a submission to CS1319 Program Language Design and Implementation. The specification to the assignment can be found at https://drive.google.com/file/d/17_Euz51EwuzNpOFmfZR3wU2qO_-vOGU0/view?usp=sharing 

## Running the analyzer
To run the analyzer you must first add the code to be translated to the ```.nc``` file that exists, here ```A2_12.nc``` is the file in ```./lexicalAnalyzer/NanoC Analyzer```. Following that, you run the command ```make -f Makefile``` to generate the tokens for the given input. The output, tokenized version of the code stripped off comments can be found at ```./out.txt```.

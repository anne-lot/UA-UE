setwd("/Users/CrazyCatLady/Desktop/image_final/")

imageNames = list.files(getwd(), pattern = "*.png")
imageNames

pasteLatex = paste("\\begin{figure} \n \\centering \n \\includegraphics[width=0.7\\textwidth]{",imageNames,"} \n \\end{figure}",sep="")

for(i in 1:1)
{
  
  indeces = 1:length(pasteLatex)
  indeces = sample(indeces, length(indeces))


   makeFile = pasteLatex[indeces]

   names_excel = imageNames[indeces]
   
   excelOutput = file(paste(i,".csv", sep=""),"w")
   writeLines(paste("Participantnummer:",i), con=excelOutput, sep="\n")
   writeLines(names_excel, con=excelOutput, sep="\n")
   close(excelOutput)
   

stop = FALSE
counter = 0
while (stop == FALSE)
{
  counter = counter + 3
  if (counter > length(makeFile))
  {
    stop = TRUE
  }
  else
  {
    makeFile = append(makeFile, "\\clearpage", after= counter)
    counter = counter + 1
  }
}

subjectNumber = paste("Participantnummer{", i,"}", sep="")

latexInput = file("latexInput.txt","w")
#writeLines("\\SetBgContents{some additional text}", con=latexInput, sep="\n")
writeLines(subjectNumber, con=latexInput, sep="\n")
writeLines(makeFile, con=latexInput, sep="\n")

close(latexInput)

system("pdflatex template_Survey.tex")
file.rename("template_Survey.pdf", paste(i,".pdf", sep = ""))


}
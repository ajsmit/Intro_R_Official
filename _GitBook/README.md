This is the directory containing the files to make a [bookdown](https://bookdown.org/home/about.html) book for the Intro R Workshop. You can find the files online at <https://ajsmit.github.io/Intro_R_Official/>.

To render this GitBook first change the working directory to `setwd(".GitBook")` and then in the console run `bookdown::render_book("index.Rmd", output = "all")`. This will produce all of the available output types and so may take several minutes to finish. This is necessary to update the PDF and EPUB files that are then made avilable for download via the online GitBook. It currently falls over when it attempts the EPUB. But the PDF works. So...

To run individual chapters one may use the knit button/keyboard command (ctrl shift k) to knit only that one chapter. This may then be pushed to GitHub to update the GitBook, but will not update the download formats.

All of the content of this repository is licensed [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

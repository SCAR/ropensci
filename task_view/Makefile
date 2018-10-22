all: README.md

Antarctic.ctv: antarctic.md buildxml.R
	pandoc -w html -o Antarctic.ctv antarctic.md
	R -e 'source("buildxml.R")'

Antarctic.html: Antarctic.ctv
	R -e 'if(!require("ctv")) install.packages("ctv", repos = "https://cran.rstudio.com/"); ctv::ctv2html("Antarctic.ctv"); source("process.R")'

README.md: Antarctic.html
	pandoc -w gfm -o README.md Antarctic.html
	sed -i.tmp -e 's|( \[|(\[|g' README.md
	sed -i.tmp -e 's| : |: |g' README.md
	sed -i.tmp -e 's|../packages/|https://cran.rstudio.com/web/packages/|g' README.md
	# sed -i.tmp -e '4s/.*/| | |\n|---|---|/' README.md
	#sed -i.tmp -e '4i/*Do not edit this README by hand. See \[CONTRIBUTING.md\]\(CONTRIBUTING.md\).*\n/' README.md
	rm *.tmp

README.html: README.md
	pandoc --from=gfm -o README.html README.md

check:
	R -e 'if(!require("ctv")) install.packages("ctv", repos = "https://cran.rstudio.com/"); print(ctv::check_ctv_packages("Antarctic.ctv", repos = "https://cran.rstudio.com/"))'

checkurls:
	R -e 'source("checkurls.R")'
	

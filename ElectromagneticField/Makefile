PROJECT:=ElectromagneticField

BUILD_DIR:=build

OUTPUT:=${BUILD_DIR}/${PROJECT}.pdf

FLAGS:=-xelatex -synctex=1 -interaction=nonstopmode -file-line-error -output-directory=${BUILD_DIR}

STYS:=$(wildcard *.sty)
CLSS:=$(wildcard *.cls)
TEXS:=$(filter-out .fig.tex,$(wildcard *.tex))
FIGS:=$(wildcard *.fig.tex)
OCTS:=$(wildcard *.fig.m)
WLSS:=$(wildcard *.fig.wls)

FIGS_PDF:=$(addprefix ${BUILD_DIR}/,$(FIGS:.tex=.pdf))
OCTS_PDF:=$(addprefix ${BUILD_DIR}/,$(OCTS:.m=.pdf))
WLSS_PDF:=$(addprefix ${BUILD_DIR}/,$(WLSS:.wls=.pdf))

default: ${BUILD_DIR} ${OUTPUT}
	@echo Makefile: Done!

${OUTPUT}: ${TEXS} ${FIGS_PDF} ${OCTS_PDF} ${WLSS_PDF} ${STYS} ${CLSS}
	latexmk ${FLAGS} ${PROJECT}.tex

${BUILD_DIR}/%.fig.pdf:%.fig.tex ${STYS} ${CLSS}
	latexmk ${FLAGS} $<

${BUILD_DIR}/%.fig.pdf:%.fig.m
	octave-cli $<

${BUILD_DIR}/%.fig.pdf:%.fig.wls
	wolframscript.exe -script $<

${BUILD_DIR}:
	mkdir -p ${BUILD_DIR}

run:default
	start ${OUTPUT}

output:
	@echo ${OUTPUT}
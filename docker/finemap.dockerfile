FROM gaow/base-notebook:1.0.0

LABEL maintainer="Diana Cornejo <dmc2245@cumc.columbia.edu>"
   
USER root

RUN R --slave -e 'remotes::install_github("stephenslab/susieR")' 
RUN R --slave -e 'install.packages("corrplot")'


RUN curl -s -o /usr/local/bin/pull-tutorial.sh https://raw.githubusercontent.com/statgenetics/statgen-courses/master/src/pull-tutorial.sh
RUN chmod a+x /usr/local/bin/pull-tutorial.sh
    
# Insert this to the notebook startup script,
# https://github.com/jupyter/docker-stacks/blob/fad26c25b8b2e8b029f582c0bdae4cba5db95dc6/base-notebook/Dockerfile#L151
RUN sed -i '2 i \
	pull-tutorial.sh finemap & \
	'  /usr/local/bin/start-notebook.sh

RUN chmod a+x /usr/local/bin/convert-ipynb.sh

USER jovyan

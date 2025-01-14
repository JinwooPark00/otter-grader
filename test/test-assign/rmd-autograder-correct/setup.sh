#!/usr/bin/env bash

# apt-get clean
# apt-get update
# apt-get install -y python3.7 python3-pip python3.7-dev

apt-get clean
apt-get update
apt-get install -y pandoc
apt-get install -y texlive-xetex texlive-fonts-recommended texlive-generic-recommended

# install wkhtmltopdf
wget --quiet -O /tmp/wkhtmltopdf.deb https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.bionic_amd64.deb
apt-get install -y /tmp/wkhtmltopdf.deb

# update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1

# try to set up R
apt-get clean
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/'

add-apt-repository ppa:cran/libgit2
apt-get update
apt-get install -y build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev libgit2-dev

# install conda
wget -nv -O /autograder/source/miniconda_install.sh "https://repo.anaconda.com/miniconda/Miniconda3-py38_4.9.2-Linux-x86_64.sh"
chmod +x /autograder/source/miniconda_install.sh
/autograder/source/miniconda_install.sh -b
echo "export PATH=/root/miniconda3/bin:\$PATH" >> /root/.bashrc

export PATH=/root/miniconda3/bin:$PATH
export TAR="/bin/tar"

# # install R dependencies
# conda install --yes r-base r-essentials 
# conda install --yes r-devtools -c conda-forge

# # install requirements
# pip3 install -r /autograder/source/requirements.txt
# pip install -r /autograder/source/requirements.txt
# Rscript /autograder/source/requirements.r

# install dependencies with conda
conda env create -f /autograder/source/environment.yml
conda run -n otter-env Rscript /autograder/source/requirements.r

# set conda shell
conda init --all

# install ottr; not sure why it needs to happen twice but whatever
git clone --single-branch -b stable https://github.com/ucbds-infra/ottr.git /autograder/source/ottr
cd /autograder/source/ottr 
conda run -n otter-env Rscript -e "devtools::install\\(\\)"
conda run -n otter-env Rscript -e "devtools::install\\(\\)"
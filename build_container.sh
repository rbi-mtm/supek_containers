# Run this script as bash build_container.sh CONTAINER_NAME.sif CONTAINER_DEF_FILE.def

STARTING_DIRECTORY=$PWD

DEF_FILE="$(realpath $2)"

cd /scratch/apptainer
mkdir ${USER}
cd ${USER}
rm -rf tmp
mkdir tmp

export APPTAINER_TMPDIR=/scratch/apptainer/${USER}/tmp
unset TMPDIR

apptainer build $1 $DEF_FILE

cp $1 $STARTING_DIRECTORY

rm -rf tmp
cd $STARTING_DIRECTORY

run_dir=~/www/Diagrams/WZJJTo1E2MuJJ

cp ${run_dir}/HTML/info.html info.md
mkdir SubProcesses
sed -i "s/\.\.\///g" info.md

for i in $(ls -d ${run_dir}/SubProcesses/P*); do
    dir=SubProcesses/$(basename $i)
    mkdir $dir
    html_file=$i/*.html 
    html_file_name=`basename $html_file`
    cp $html_file $dir/${html_file_name/html/md}
    cp $i/*.ps $dir
    cp $i/*.jpg $dir
done

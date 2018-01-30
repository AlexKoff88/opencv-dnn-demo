Function DeGZip-File{
    Param(
        $infile
        )
    $outFile = $infile.Substring(0, $infile.LastIndexOfAny('.'))
    $input = New-Object System.IO.FileStream $inFile, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::Read)
    $output = New-Object System.IO.FileStream $outFile, ([IO.FileMode]::Create), ([IO.FileAccess]::Write), ([IO.FileShare]::None)
    $gzipStream = New-Object System.IO.Compression.GzipStream $input, ([IO.Compression.CompressionMode]::Decompress)

    $buffer = New-Object byte[](1024)
    while($true){
        $read = $gzipstream.Read($buffer, 0, 1024)
        if ($read -le 0){break}
        $output.Write($buffer, 0, $read)
        }

    $gzipStream.Close()
    $output.Close()
    $input.Close()
}

function Expand-Tar($tarFile, $dest) {

    if (-not (Get-Command Expand-7Zip -ErrorAction Ignore)) {
        Install-Package -Scope CurrentUser -Force 7Zip4PowerShell > $null
    }

    Expand-7Zip $tarFile $dest
}

mkdir -Name data

# GoogLeNet data
wget https://raw.githubusercontent.com/opencv/opencv_extra/master/testdata/dnn/bvlc_googlenet.prototxt -OutFile data/bvlc_googlenet.prototxt
#wget http://dl.caffe.berkeleyvision.org/bvlc_googlenet.caffemodel -OutFile data/bvlc_googlenet.caffemodel
wget https://raw.githubusercontent.com/HoldenCaulfieldRye/caffe/master/data/ilsvrc12/synset_words.txt -OutFile data/synset_words.txt
wget https://github.com/opencv/opencv_extra/blob/master/testdata/dnn/googlenet_1.png?raw=true -OutFile data/googlenet_1.png

# MobileNet data
# TensorFlow
wget	 http://download.tensorflow.org/models/object_detection/ssd_mobilenet_v1_coco_11_06_2017.tar.gz  -OutFile data/ssd_mobilenet_v1_coco_11_06_2017.tar.gz
DeGZip-File 'data/ssd_mobilenet_v1_coco_11_06_2017.tar.gz'
Expand-Tar data/ssd_mobilenet_v1_coco_11_06_2017.tar data
# Caffe
wget "https://drive.google.com/uc?export=download&id=0B3gersZ2cHIxRm5PMWRoTkdHdHc" -OutFile data/MobileNetSSD_deploy.caffemodel
wget "https://raw.githubusercontent.com/chuanqi305/MobileNet-SSD/daef68a6c2f5fbb8c88404266aa28180646d17e0/MobileNetSSD_deploy.prototxt" -OutFile data/MobileNetSSD_deploy.prototxt
wget "https://github.com/opencv/opencv_extra/blob/master/testdata/dnn/dog416.png?raw=true"  -OutFile data/dog416.png


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

function download-file($url, $dest) {
    if(![System.IO.File]::Exists($dest)){
		wget $url -OutFile $dest
	}	
}

mkdir -Name data

download-file "https://raw.githubusercontent.com/opencv/opencv_extra/3.4/testdata/dnn/bvlc_googlenet.prototxt" data/bvlc_googlenet.prototxt
download-file "http://dl.caffe.berkeleyvision.org/bvlc_googlenet.caffemodel" data/bvlc_googlenet.caffemodel
download-file "https://raw.githubusercontent.com/HoldenCaulfieldRye/caffe/master/data/ilsvrc12/synset_words.txt" data/synset_words.txt
download-file "https://raw.githubusercontent.com/opencv/opencv_extra/3.4/testdata/dnn/googlenet_1.png" data/googlenet_1.png
download-file "https://raw.githubusercontent.com/opencv/opencv_extra/3.4/testdata/dnn/space_shuttle.jpg" data/space_shuttle.jpg
# MobileNet data
# TensorFlow
download-file "https://raw.githubusercontent.com/opencv/opencv_extra/3.4/testdata/dnn/ssd_mobilenet_v1_coco.pbtxt" data/ssd_mobilenet_v1_coco.pbtxt
download-file "http://download.tensorflow.org/models/object_detection/ssd_mobilenet_v1_coco_11_06_2017.tar.gz" data/ssd_mobilenet_v1_coco_11_06_2017.tar.gz
DeGZip-File 'data/ssd_mobilenet_v1_coco_11_06_2017.tar.gz'
Expand-Tar data/ssd_mobilenet_v1_coco_11_06_2017.tar data
# Caffe
download-file "https://drive.google.com/uc?export=download&id=0B3gersZ2cHIxRm5PMWRoTkdHdHc" data/MobileNetSSD_deploy.caffemodel
download-file "https://raw.githubusercontent.com/chuanqi305/MobileNet-SSD/daef68a6c2f5fbb8c88404266aa28180646d17e0/MobileNetSSD_deploy.prototxt" data/MobileNetSSD_deploy.prototxt
download-file "https://raw.githubusercontent.com/opencv/opencv_extra/3.4/testdata/dnn/dog416.png" data/dog416.png

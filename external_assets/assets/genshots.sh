#! /bin/env bash

convert assets/bg.tga \( \( input/input_01.png -scale 750x -page 852x1740+51+49 -background transparent -flatten \) assets/frame.png -composite -page 1512x2688+330+660 -background transparent -flatten \) -composite \( -font "assets/Poppins-Bold.ttf" -pointsize 88 -fill white -gravity center label:@input/input_01.txt -page x1000+0+60 -flatten  \) -gravity north -composite temp.tga
convert temp.tga -page 1242x2688-135+0 -flatten output/screenshot_01.png
convert temp.tga -scale 1242x output/screenshot_01_apple_5.5_pouces.png
convert temp.tga output/screenshot_01_android.png

convert assets/bg.tga \( \( input/input_02.png -scale 750x -page 852x1740+51+49 -background transparent -flatten \) assets/frame.png -composite -page 1512x2688+330+660 -background transparent -flatten \) -composite \( -font "assets/Poppins-Bold.ttf" -pointsize 88 -fill white -gravity center label:@input/input_02.txt -page x1000+0+60 -flatten  \) -gravity north -composite temp.tga
convert temp.tga -page 1242x2688-135+0 -flatten output/screenshot_02.png
convert temp.tga -scale 1242x output/screenshot_02_apple_5.5_pouces.png
convert temp.tga output/screenshot_02_android.png

convert assets/bg.tga \( \( input/input_03.png -scale 750x -page 852x1740+51+49 -background transparent -flatten \) assets/frame.png -composite -page 1512x2688+330+660 -background transparent -flatten \) -composite \( -font "assets/Poppins-Bold.ttf" -pointsize 88 -fill white -gravity center label:@input/input_03.txt -page x1000+0+60 -flatten  \) -gravity north -composite temp.tga
convert temp.tga -page 1242x2688-135+0 -flatten output/screenshot_03.png
convert temp.tga -scale 1242x output/screenshot_03_apple_5.5_pouces.png
convert temp.tga output/screenshot_03_android.png

convert assets/bg.tga \( \( input/input_04.png -scale 750x -page 852x1740+51+49 -background transparent -flatten \) assets/frame.png -composite -page 1512x2688+330+660 -background transparent -flatten \) -composite \( -font "assets/Poppins-Bold.ttf" -pointsize 88 -fill white -gravity center label:@input/input_04.txt -page x1000+0+60 -flatten  \) -gravity north -composite temp.tga
convert temp.tga -page 1242x2688-135+0 -flatten output/screenshot_04.png
convert temp.tga -scale 1242x output/screenshot_04_apple_5.5_pouces.png
convert temp.tga output/screenshot_04_android.png

convert assets/bg.tga \( \( input/input_05.png -scale 750x -page 852x1740+51+49 -background transparent -flatten \) assets/frame.png -composite -page 1512x2688+330+660 -background transparent -flatten \) -composite \( -font "assets/Poppins-Bold.ttf" -pointsize 88 -fill white -gravity center label:@input/input_05.txt -page x1000+0+60 -flatten  \) -gravity north -composite temp.tga
convert temp.tga -page 1242x2688-135+0 -flatten output/screenshot_05.png
convert temp.tga -scale 1242x output/screenshot_05_apple_5.5_pouces.png
convert temp.tga output/screenshot_05_android.png

convert assets/bg.tga \( \( input/input_06.png -scale 750x -page 852x1740+51+49 -background transparent -flatten \) assets/frame.png -composite -page 1512x2688+330+660 -background transparent -flatten \) -composite \( -font "assets/Poppins-Bold.ttf" -pointsize 88 -fill white -gravity center label:@input/input_06.txt -page x1000+0+60 -flatten  \) -gravity north -composite temp.tga
convert temp.tga -page 1242x2688-135+0 -flatten output/screenshot_06.png
convert temp.tga -scale 1242x output/screenshot_06_apple_5.5_pouces.png
convert temp.tga output/screenshot_06_android.png

convert assets/bg.tga \( \( input/input_07.png -scale 750x -page 852x1740+51+49 -background transparent -flatten \) assets/frame.png -composite -page 1512x2688+330+660 -background transparent -flatten \) -composite \( -font "assets/Poppins-Bold.ttf" -pointsize 88 -fill white -gravity center label:@input/input_07.txt -page x1000+0+60 -flatten  \) -gravity north -composite temp.tga
convert temp.tga -page 1242x2688-135+0 -flatten output/screenshot_07.png
convert temp.tga -scale 1242x output/screenshot_07_apple_5.5_pouces.png
convert temp.tga output/screenshot_07_android.png


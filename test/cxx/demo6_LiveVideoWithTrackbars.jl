######################################################################################
#
# demo 6: Interactive brightness/contrast adjustment of live webcam with trackbars
#
######################################################################################

device_index = CAP_ANY

# C++ OpenCV code
cxx"""
void liveVideo_adjust(int device_index) {

    // open Video device
    cv::VideoCapture capture(device_index);

     //Check that it is indeed open
    if (!capture.isOpened())
    {
       std::cout<< "Can not open camera!";
       exit(0);
    }

    // Create a window to show the frames
    namedWindow("Welcome!", cv::WINDOW_AUTOSIZE);

    // Create trackbars for brightness and contrast
    int iValueForBrightness = 50;
    int iValueForContrast = 50;

    cv::createTrackbar("Brightness", "Welcome!", &iValueForBrightness, 100);
    cv::createTrackbar("Contrast", "Welcome!", &iValueForContrast, 100);

    // Set the frame size to the camera capture WIDTH and HEIGHT
    double dWidth = capture.get(cv::CAP_PROP_FRAME_WIDTH);
    double dHeight = capture.get(cv::CAP_PROP_FRAME_HEIGHT);

    int Height = static_cast<int>(dHeight);
    int Width = static_cast<int>(dWidth);

    // Initialize the cv::Mat structures
    cv::Mat frame(Width,Height, CV_8UC3);
    cv::Mat converted(Width,Height, CV_8UC3);

    // Loop until user presses ESC or frame is empty
    while(true)
    {
        bool Success = capture.read(frame);

        if (!Success) {
            break;
        }

        int iBrightness = iValueForBrightness -50;
        double dContrast = iValueForContrast/50.0;

        //cv::cvtColor(frame, frame, cv::COLOR_BGR2GRAY);
        //cv::equalizeHist(frame, converted);

        frame.convertTo(converted, -1, dContrast, iBrightness);

        cv::imshow("Welcome!", converted);

        if (cv::waitKey(30) == 27)
        {
            cv::destroyWindow("Welcome!");
            break;
        }
    }
}
"""

@cxx liveVideo_adjust(device_index)




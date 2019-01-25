CXX=g++ -std=c++11
SOURCES=xiVideoCapture.cpp
SOURCES+=xiApiPlusOcv.cpp
OBJECTS=$(SOURCES:.cpp=.o)
PROGRAM=xiVideoCapture


all: $(PROGRAM)

$(PROGRAM): xiApiPlusOcv.o xiVideoCapture.o
	$(CXX) -std=c++11 $(OBJECTS) -o xiVideoCapture -lm3api -lopencv_core -lopencv_highgui -lopencv_imgproc -lopencv_videoio -L/usr/local/lib 

xiApiPlusOcv.o: xiApiPlusOcv.cpp
	$(CXX) -c xiApiPlusOcv.cpp -I . -I /usr/local/include/ -g3 -Wall -c -fmessage-length=0

xiVideoCapture.o: xiVideoCapture.cpp
	$(CXX) xiVideoCapture.cpp -I .  -I /usr/local/include/ -g3 -Wall -c -fmessage-length=0

clean:
	rm -f *.o *~ $(PROGRAM) $(OBJECTS)







CXX=g++ -std=c++11
SOURCES=xiRecordForArchive.cpp
SOURCES+=xiApiPlusOcv.cpp
OBJECTS=$(SOURCES:.cpp=.o)
PROGRAM=xiRecordForArchive


all: $(PROGRAM)

$(PROGRAM): xiApiPlusOcv.o xiRecordForArchive.o
	$(CXX) $(OBJECTS) -o xiRecordForArchive -lm3api -lopencv_core -lopencv_highgui -lopencv_imgproc -lopencv_videoio -lncurses -L/usr/local/lib

xiApiPlusOcv.o: xiApiPlusOcv.cpp
	$(CXX) -c xiApiPlusOcv.cpp -I. -I /usr/local/include/ -g3 -lm3api -L/usr/local/lib -Wall

xiRecordForArchive.o: xiRecordForArchive.cpp xiApiPlusOcv.o
	$(CXX) -c xiRecordForArchive.cpp -I. -I /usr/local/include/ -g3 -lm3api -L/usr/local/lib -Wall

clean:
	rm -f *.o *~ $(PROGRAM) $(OBJECTS)

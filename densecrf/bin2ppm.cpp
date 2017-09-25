#include <cstdio>

#include <iostream>
#include <vector>
#include <cmath>
#include <cstdlib>
#include <string.h>
#include <fstream>
#include <dirent.h>
#include <fnmatch.h>

#include "../libDenseCRF/util.h"

using namespace std;

// colour map
unsigned char colors[21][3] = {{0,0,0}
                // 0=background
                ,{128,0,0},{0,128,0},{128,128,0},{0,0,128},{128,0,128}
                // 1=aeroplane, 2=bicycle, 3=bird, 4=boat, 5=bottle
                ,{0,128,128},{128,128,128},{64,0,0},{192,0,0},{64,128,0}
                // 6=bus, 7=car, 8=cat, 9=chair, 10=cow
                ,{192,128,0},{64,0,128},{192,0,128},{64,128,128},{192,128,128}
                // 11=diningtable, 12=dog, 13=horse, 14=motorbike, 15=person
                ,{0,64,0},{128,64,0},{0,192,0},{128,192,0},{0,64,128}};
                // 16=potted plant, 17=sheep, 18=sofa, 19=train, 20=tv/monitor;
const int num_classes = 21;

// Produce a color image from a bunch of labels
unsigned char * colorize( const short * img, int W, int H ){
  unsigned char * r = new unsigned char[ W*H*3 ];
  for( int h=0; h<H; h++ ){
    for( int w=0; w<W; w++ ){
      int n = img[w*H+h];
      if(n >= num_classes) {
        n = 0;
      }
      memcpy( r+W*h*3+w*3, colors[n], 3 );
    }
  }
  return r;
}

template <typename T>
void LoadBinFile(const char *fn, T*& data, 
    int* row, int* col, int* channel) {
  //data.clear();

  std::ifstream ifs(fn, std::ios_base::in | std::ios_base::binary);

  if(!ifs.is_open()) {
    std::cerr << "Fail to open " << fn << std::endl;
  }

  int num_row, num_col, num_channel;

  ifs.read((char*)&num_row, sizeof(int));
  ifs.read((char*)&num_col, sizeof(int));
  ifs.read((char*)&num_channel, sizeof(int));

  int num_el;

  num_el = num_row * num_col * num_channel;

  data = new T[num_el];

  ifs.read((char*)&data[0], sizeof(T)*num_el);

  ifs.close();

  if(row!=NULL) {
    *row = num_row;
  }

  if(col!=NULL) {
    *col = num_col;
  }
 
  if(channel != NULL) {
    *channel = num_channel;
  }

}

int main( int argc, char* argv[]) {
	if(argc != 3) {
		printf("Usage: %s input.bin output.ppm\n", argv[0] );
		return 1;
	}
	
	short *bin = NULL;
	int W=0, H=0, channel=0;
	LoadBinFile(argv[1], bin, &H, &W, &channel);
	
	// cout << "W = " << W << ", H = " << H << ", channel = " << channel << endl;
	
	unsigned char *res = colorize( bin, W, H );
	writePPM( argv[2], W, H, res );
	
	delete[] bin;
	delete[] res;
	
	return 0;
}


//
//  CountryListView.swift
//  iOS-Assignment3
//
//  Created by Daniel
//

import SwiftUI

struct CountryListView: View {
    var arr = [1,2,3,4,5,6,7,8,9];
    
    var body: some View {
        Text("COUNTRY LIST VIEW - DANIEL PART")
        
        //  Country List
        VStack{
            
            //  LOOPING through country array
            ForEach(arr, id: \.self){country in
                HStack{
                    AsyncImage(url: URL(string: "https://flagcdn.com/w320/vn.png")){image in
                        image.image?.resizable()
                    }
                    .frame(width: 60, height: 40)
                        
                    
                    Text("\(country)");
                    
                    Spacer();
                    
                    Image(systemName: "heart");
                }
                .padding(.horizontal, 55);
            }
        }
    }
}

#Preview {
    CountryListView()
}

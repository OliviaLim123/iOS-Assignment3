//
//  CountryListView.swift
//  iOS-Assignment3
//
//  Created by Daniel
//

import SwiftUI

struct CountryListView: View {
    
    //  PROPERTIES
    //  STATE Properties
    @State var viewModel = AppViewModel.shared;
    @State var countryAPI: CountryManager;
    @State private var displayList: [Country] = [];
    @State private var searchString: String = "";
    
    var arr = [1,2,3,4,5,6,7,8,9];
    
    //  FUNCTIONS
    init(){
        countryAPI = CountryManager();
    }
    
    var body: some View {
        
        //  OUTERMOST VStack
        VStack{
//            Text("COUNTRY LIST VIEW - DANIEL PART");
            
            //  Search Bar
            searchBarView;
            
            //  LOGO IMAGE
            Image("logo")
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.vertical, 10);
            
            //  LOOPING through country array
            //  COUNTRIES List
            countryListView;
            
        }   //  OUTERMOST VSTACK
        .padding(.horizontal, 35);
    }
    
    //  COUNTRIES List VIEW
    var countryListView: some View{
        ScrollView {
            
            ForEach(displayList){country in
                HStack{
                    AsyncImage(url: URL(string: country.flags.png)){ image in
                        image.resizable();
                    } placeholder: {
                        Color.gray;
                    }
                    .border(.gray)
                    .frame(width: 55, height: 38)
                    
                    Text("\(country.name.common)")
                        .font(.custom("MontserratAlternates-SemiBold", size: 20))
                        .tracking(2)
                        .foregroundStyle(.textColour)
                        .padding(.horizontal, 10);
                    
                    Spacer();
                    
                    //  BUTTON Image will be "heart.fill" if in FAV List
                    //  BUTTON Image will be "heart" if not in FAV List
                    Button{
                        
                    } label:{
                        Image(systemName: "heart.fill")
                            .font(.custom("MontserratAlternates-SemiBold", size: 22))
                            .foregroundStyle(.red);
                    }                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.sweetCorn)
                        .opacity(0.55))
                //  PADDING Around Button
                .padding(.vertical, 3);
                
            }
            
            
        }
        .onAppear(){
            countryAPI.fetchAllCountries();
        }
        .onReceive(countryAPI.$countriesList) { countryData in
            if let safeCountryData = countryData{
                displayList = safeCountryData;
                print(displayList[0].name.common)
            }
        }
    }
    
    var searchBarView: some View{
        ZStack {
            HStack {
                TextField("Search a country", text: $searchString)
                    .font(.custom("MontserratAlternates-SemiBold", size: 20))
                    .foregroundStyle(.textColour)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10.0);
                
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                    .foregroundStyle(.textColour.opacity(0.8))
                
            } //HStack
            //  INNER SHADOW (for TextField)
            .background{
                ZStack{
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.pinkCustom)
                        .frame(height: 50)
                        .padding(.horizontal, -15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // The shape of the overlay should match the element
                                .stroke(Color.gray, lineWidth: 4) // Border color and width
                                .blur(radius: 3) // Blur the border to create a soft shadow effect
                                .offset(x: 0, y: 2) // Offset of the shadow
                                .mask(
                                    RoundedRectangle(cornerRadius: 10) // Mask using the same shape as the element
                                        .fill(
                                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .top, endPoint: .bottom)
                                        )
                                )
                                .padding(.horizontal, -15)
                        )
                }
            }
            .padding()
        }//ZStack S.
    }
}

#Preview {
    CountryListView()
}

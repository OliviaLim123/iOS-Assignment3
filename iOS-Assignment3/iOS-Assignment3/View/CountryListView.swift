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
    @StateObject var viewModel: AppViewModel;
    @State var countryAPI: CountryManager;
    @State private var displayList: [Country] = [];
    @State private var searchString: String = "";
    var filteredList: [Country] {
        if searchString.isEmpty {
            return displayList
        } else {
            return displayList.filter { country in
                country.name.common.localizedCaseInsensitiveContains(searchString)
            }
        }
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
            
            ForEach(filteredList){country in
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
                    
                    //  HEART Button
                    heartButton(country: country);
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.sweetCorn)
                        .opacity(0.55))
                //  PADDING Around Button
                .padding(.vertical, 3)
                .onTapGesture {
                    viewModel.selectedCountry = country.cca3;
                    viewModel.currentTab = "Info"
                };
                
            }
            
        }
        .onAppear(){
            countryAPI.fetchAllCountries();
        }
        .onReceive(countryAPI.$countriesList) { countryData in
            if let safeCountryData = countryData{
                displayList = safeCountryData;
            }
        }
    }
    
    //  HEART Button View
    func heartButton(country: Country) -> some View{
        //  BUTTON Image will be "heart.fill" if in FAV List
        //  BUTTON Image will be "heart" if not in FAV List
        Button{
            if(viewModel.isInFavList(countryCode: country.cca3)){
                viewModel.userFavList.removeAll{
                    $0 == country.cca3
                };
            }
            else{
                viewModel.userFavList.append(country.cca3);
            }
        } label:{
            if(viewModel.isInFavList(countryCode: country.cca3)){
                Image(systemName: "heart.fill")
                    .font(.custom("MontserratAlternates-SemiBold", size: 22))
                    .foregroundStyle(.red);
            }
            else{
                Image(systemName: "heart")
                    .font(.custom("MontserratAlternates-SemiBold", size: 22))
                    .foregroundStyle(.black);
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
    CountryListView(viewModel: AppViewModel(), countryAPI: CountryManager())
}

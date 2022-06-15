import SwiftUI

var data = ["Engineer","Digital Artist","Game Developer","UI/UX Developer", "Logo Designer","Blogger", "Web Developer" , "IOS Developer" , "Android Developer" , "Other"]

var age = ["18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35"]

struct ContentView: View {
    var body: some View {
        FinalView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct FinalView: View {
    
    @State private var image: Image?
    @State private var isShowingPhoto = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            FinalPicker1().offset(x: 5, y: 100)
            FinalPicker2().offset(x: 5, y: 280)
            
            Circle()
                .foregroundColor(.gray).opacity(0.2)
                .frame(width: 500, height: 500, alignment: .center)
                .overlay( Circle().stroke(Color.white, lineWidth: 3))
                .offset(x: 0, y: -350)
            
            VStack{
                ZStack{
                    Image("download")
                        .resizable()
                        .scaledToFill()
                    
                    image?
                        .resizable()
                }.onTapGesture { isShowingPhoto = true }
            }
                .frame(width: 250, height: 250, alignment: .center)
                .clipShape(Circle())
                .overlay( Circle().stroke(Color.white, lineWidth: 2))
                .offset(x: 0, y: -150)
        }
        .onChange(of: inputImage) { _ in loadImage() }
        .fullScreenCover(isPresented: $isShowingPhoto, onDismiss: nil) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct FinalPicker1: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.clear)
                .frame(width: 300, height: 80, alignment: .center)
                .background(Color.black)
                .overlay( RoundedRectangle(cornerRadius: 25.0).stroke(Color.white, lineWidth: 2))
            
            ZStack{
                Circle()
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60, alignment: .center)
                
                Text("I'm")
                    .font(.system(size: 40))
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
            }
            .offset(x: -160, y: 0)
            
            CustomPicker()
        }
    }
}

struct FinalPicker2: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.clear)
                .frame(width: 300, height: 80, alignment: .center)
                .background(Color.black)
                .overlay( RoundedRectangle(cornerRadius: 25.0).stroke(Color.white, lineWidth: 2))
            
            ZStack{
                Circle()
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60, alignment: .center)
                
                Text("Age")
                    .font(.system(size: 40))
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                
            }
            .offset(x: -160, y: 0)
            
            CustomPicker2()
        }
    }
}

struct CustomPicker: UIViewRepresentable {
    func makeCoordinator() -> CustomPicker.Coordinator {
        return CustomPicker.Coordinator(parent1: self)
    }
    
    func makeUIView(context : UIViewRepresentableContext<CustomPicker>) -> UIPickerView {
        let picker = UIPickerView()
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIView(_ uiView : CustomPicker.UIViewType , context : UIViewRepresentableContext<CustomPicker>){ }
    
    class Coordinator: NSObject,UIPickerViewDelegate,UIPickerViewDataSource{
        var parent : CustomPicker
        init(parent1 : CustomPicker){
            parent = parent1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return data.count
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            
            let view = UIView(frame: CGRect(x : 0 , y : 0 , width: UIScreen.main.bounds.width - 100 , height: 60))
            let label = UILabel(frame:  CGRect(x : 0 ,y : 0 , width : view.bounds.width , height: view.bounds.height))
            
            label.text = data[row]
            label.textColor = .white
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 30, weight: .bold)
            
            view.backgroundColor = .clear
            
            view.addSubview(label)
            
            return view
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return UIScreen.main.bounds.width - 100
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 60
        }
    }
}

struct CustomPicker2: UIViewRepresentable {
    
    func makeCoordinator() -> CustomPicker2.Coordinator {
        return CustomPicker2.Coordinator(parent2: self)
    }
    
    func makeUIView(context : UIViewRepresentableContext<CustomPicker2>) -> UIPickerView {
        let picker = UIPickerView()
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIView(_ uiView : CustomPicker2.UIViewType , context : UIViewRepresentableContext<CustomPicker2>){ }
    
    class Coordinator: NSObject,UIPickerViewDelegate,UIPickerViewDataSource{
        
        var parent : CustomPicker2
        init(parent2 : CustomPicker2){
            parent = parent2
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return age.count
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            
            let view = UIView(frame: CGRect(x : 0 , y : 0 , width: UIScreen.main.bounds.width - 100 , height: 60))
            let label = UILabel(frame:  CGRect(x : 0 ,y : 0 , width : view.bounds.width , height: view.bounds.height))
            
            label.text = age[row]
            label.textColor = .white
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 30, weight: .bold)
            
            view.backgroundColor = .clear
            view.addSubview(label)
            
            return view
        }
        
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return UIScreen.main.bounds.width - 100
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 60
        }
    }
}

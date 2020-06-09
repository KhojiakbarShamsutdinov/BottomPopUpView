# BottomPopUpView
A CocoaPods library written in Swift

<div class="img_div">
<img src="https://github.com/KhojiakbarShamsutdinov/BottomPopUpView/blob/master/BottomPopUpViewExamples/Screenshots/3.gif" width="212" height="480" />
<img src="https://github.com/KhojiakbarShamsutdinov/BottomPopUpView/blob/master/BottomPopUpViewExamples/Screenshots/2.gif" width="212" height="480" />
<img src="https://github.com/KhojiakbarShamsutdinov/BottomPopUpView/blob/master/BottomPopUpViewExamples/Screenshots/1.gif" width="212" height="480" />
</div>

<br><br>
Must have and easy to use library.

<h1> Usage </h1>
<h3> In Your VC Add the following: </h3>

        let bottomPopUpView = BottomPopUpView(wrapperContentHeight: self.view.frame.height) /* Create an instance of BottomPopUpView with height */
        
        bottomPopUpView.tableView.dataSource = self /* Set the data source of table view */
        
        /* Create a Xib UITableViewCell and register it */
        let nib = UINib(nibName: "ExampleUITableViewCell", bundle: nil)
        bottomPopUpView.tableView.register(nib, forCellReuseIdentifier: "ExampleUITableViewCell")
        
        /* Present, very easy :) */
        self.present(bottomPopUpView, animated: true, completion: nil)
        
 <br><br>
        
        class ViewController: UIViewController, UITableViewDataSource {
           func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return 1
           }
    
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleAirPodsTableViewCell") as? ExampleAirPodsTableViewCell else { return UITableViewCell() }
                return cell
           }
        }

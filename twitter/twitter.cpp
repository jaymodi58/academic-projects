#include<iostream>
#include<string>
#include<cctype>
#include<fstream>
#include<cstdlib>
using namespace std;

/*
1.Create function for getting inputs from user------getUsername().
2.Define structure named account for storing username, tweets and topics.
3.Create an array named acc of account structure.
4.Asking for option
	4.1 add user
		1.Add user as per requirement.
	4.2 sign in
		1.Call getUsername() function for getting username.
		2.Store it as acc.username.
		3.Remove space from long acc.username if any, and store it as acc.uname.
		5.Append "@" as first character in acc.uname.
		6.Open file named acc.username if any, otherwise create new file named acc.username.
		7.Store all the tweets from file in acc.tweets.
		8.Open file named acc.username_follower if any, otherwise create new file named acc.username_follower.
		9.Creating switch statement
			case 2:Adding follower if user is not already follwer.
			case 3:Finding topic from each tweet stored in acc.tweets variable.
			case 4:Label used for terminate the program.
			case 1:Asking for tweet which is going to be added in file named acc.username.
		10.Display acc.username, acc.uname, number of tweets, number of followers, tweets (if any).
		11.Finding index of "#" symbol from a tweet.
		12.Finding index of space exactly after "#" symbol in that particular tweet.
		13.Display all topics from each tweet.
		14.Repeating step-9 to step-14 untill user enters 4.		
	4.3 quit the program
*/

string getUsername()
{
	string ip;
	getline(cin,ip);
	return ip;
}
struct account
{
	string username;
	string uname;
	string tweets[100];
};

int main()
{
	ifstream inFS;
	ofstream outFS;
	
	account acc[100];
	string current_user;
	int acc_index=0;
	char path;
	
	cout << "----------------------------" << endl;
	cout << "Type \"a\" to add a user" << endl;
	cout << "Type \"q\" to quit" << endl;
	cout << "Type \"s\" to sign in" << endl;
	cout << "----------------------------" << endl;
	
	cout << "Please enter a character from the menu: ";
	cin >> path;
	
	string filename;
	while(path!='q')
	{
		switch(path)
		{
			case 'a':
			{
				cout << "Please enter a username: ";
				cin.ignore();
				
				acc[acc_index].username=getUsername();
				acc[acc_index].uname=acc[acc_index].username;
				
				int len=acc[acc_index].uname.length();
				for (int i = 0; i < len; i++) 
				{
					if(isspace(acc[acc_index].uname[i]))
					{
						acc[acc_index].uname.erase(i, 1);
						len--;
						i--;
					}
				}
				acc[acc_index].uname = "@" + acc[acc_index].uname;

				inFS.open(acc[acc_index].username.c_str());
				if (!inFS.is_open())	//file doesn't exist so creating new file
				{
					outFS.open(acc[acc_index].username.c_str());
					outFS.close();
				}
				else
					cout << "Opps...!!! User already exist." << endl;
				inFS.close();
				
				filename=acc[acc_index].username + "_follower" ;
				inFS.open(filename.c_str());
				if (!inFS.is_open())	//file doesn't exist so creating new file
				{
					outFS.open(filename.c_str());
					outFS.close();
				}
				inFS.close();
				acc_index++;
				cout << endl;
				for(int i=0;i<acc_index;i++)
					cout << acc[i].uname << endl;
				cout << endl;
				break;
			}	
			case 's':
			{
				cout << "Please enter a username: ";
				cin.ignore();
				string current_username=getUsername();
				int user_found=0;
				int ind=0;
				for(ind=0;ind<acc_index;ind++)
				{
					if(current_username==acc[ind].username)
					{
						user_found=1;
						break;
					}
					else
						cout << "User not exists." << endl;
				}
				if(user_found==1)
				{
					//-------------------------------------------------
					string tweet;
					string topic;
					string user;
					int menu=0;
					int flag=1;
					int found=0;
					int flag1=1;
					int flag2=1;
					int user_found=0;
					int followers;
					int numberOfTweets=0;
					
					filename=acc[ind].username + "_follower" ;
					inFS.open(filename.c_str());
					string follow;
					while(getline(inFS,follow))
					{
						followers++;
					}
					inFS.close();
					
					int tweet_index=0;
					inFS.open(acc[ind].username.c_str());
					while(getline(inFS,tweet))
					{
						acc[ind].tweets[tweet_index]=tweet;
						tweet_index++;
					}
					inFS.close();
					numberOfTweets=tweet_index;
					
					while(flag==1)
					{
						string follower_name;
						switch(menu)
						{
							case 2:
									cout << "Please enter the follower’s @username: " ;
									cin >> follower_name;

									inFS.open(filename.c_str());
									while(getline(inFS,user))
									{
										if(user==follower_name)
										{
											flag2=0;
											user_found=1;
											cout << endl << "Sorry, " << follower_name << " is already a follower." << endl << endl;
											break;
										}
									}
									inFS.close();
									if(user_found==0)
									{
										outFS.open(filename.c_str(),ios::app);
										outFS << follower_name << endl;
										outFS.close();
										followers++;
									}
									break;
							case 3:
									found=0;
									flag1=0;
									cout << endl << "Please enter a topic: " ;
									cin >> topic;
									for(int x=0 ; x < tweet_index ; x++)
									{
										if(acc[ind].tweets[x].find(topic) != string::npos)
										{
											found=1;
											cout << acc[ind].username << " ";
											cout << acc[ind].uname << " ";
											cout << acc[ind].tweets[x] << endl;
											cout << "-------------------------------------------------------------------------------" << endl;
										}
									}
									if(found==0)
										cout << "No topics found.";
									cout << endl << endl;
									break;
							case 4:
									flag=0;
									break;
							case 1:
									cout << "Please enter a tweet: ";
									cin.ignore();
									string new_tweet=getUsername();

									outFS.open(acc[ind].username.c_str(),ios::app);
									outFS << new_tweet << endl;
									outFS.close();

									acc[ind].tweets[tweet_index]=new_tweet;
									numberOfTweets++;
									tweet_index++;
									break;
						}

						user_found=0;

						if(flag1==1 && flag2==1)
						{
							cout << endl << "USERNAME: " << acc[ind].username << endl ;
							cout << "@USERNAME: " << acc[ind].uname << endl ;
							cout << "TWEETS: " << numberOfTweets << "\t" << "FOLLOWERS: " << followers << endl;
							cout << "------------------------------------------------------------" << endl;

							inFS.open(acc[ind].username.c_str());
							for(int x=0 ; x < tweet_index ; x++)
							{
								cout << acc[ind].username << " ";
								cout << acc[ind].uname << " ";
								cout << acc[ind].tweets[x] << endl;
								cout << "-----------------------------------------------------------" << endl;
							}
							inFS.close();
							cout << "TOPICS: ";
							for(int x=0 ; x < tweet_index ; x++)
							{		
								int hash_index,next_space_index;
								hash_index=acc[ind].tweets[x].find('#');

								if(hash_index != string::npos)
								{
									next_space_index=hash_index;

									for(int i=hash_index ; i < acc[ind].tweets[x].length() ; i++)
									{
										int tmp=acc[ind].tweets[x].find(" ",i);
										if(tmp != string::npos)
										{
											next_space_index=tmp;
											next_space_index=next_space_index-hash_index;
											break;
										}
									}
									cout << acc[ind].tweets[x].substr(hash_index,next_space_index) << "\t";
								}
							}
							cout << endl << endl;
						}
						if(flag==1)
						{
							cout << "-------YOUR MENU--------" << endl;
							cout << "Type 1 to post a tweet" << endl;
							cout << "Type 2 to add a follower" << endl;
							cout << "Type 3 to search a topic" << endl;
							cout << "Type 4 to quit" << endl;
							cout << "------------------------" << endl;
							cout << "Enter a number from the menu: ";
							cin >> menu;
							flag1=1;
							flag2=1;
						}
					}
					//--------------------------------------------------
			}
			}
		}
		cout << "----------------------------" << endl;
		cout << "Type \"a\" to add a user" << endl;
		cout << "Type \"q\" to quit" << endl;
		cout << "Type \"s\" to sign in" << endl;
		cout << "----------------------------" << endl;

		cout << "Please enter a character from the menu: ";
		cin >> path;
	}
	
	return 0;
}

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="demoApp.main" %>

<!DOCTYPE html>

<html lang="en">

<head runat="server">

    <title></title>
    <link rel="stylesheet" href="https://formden.com/static/cdn/font-awesome/4.4.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <style type="text/css">
        .main{
           background-color: #f0efeb;
        }
        .table{
            text-align:center;
        }
        #GridView1{
            margin-top: 20px;
        }
        .edit-textbox{
            width: 165px;
        }
        .edit-textbox-phone{
            width: 130px;
        }
        .edit-textbox-loc{
            width: 110px;
        }
        .edit-textbox-gen{
            width: 80px;
        }
        .edit-textbox-cal{
            width: 110px;
        }
        .edit-textbox-dona{
            width: 90px;
        }
        .btn{
            width: 100px;
            margin-top:5px;
        }
        .r2 {
            margin-left: 10px;
        }

        .check {
            margin-left: 10px;
        }

        .card {
            box-shadow: 0 0 20px rgb(0, 0, 0, 0.40);
        }
    </style>

</head>

<body class="main">

    <div class="container my-4">
        <div class="card">
            <div class="card-body">
                <div style="text-align: center; margin-top: 20px; margin-bottom:35px;">
                    <h2 style="color: #0000FF;">Join us in making a positive impact: Donate today!</h2>
                </div>

                <form class="row g-2 justify-content-md-center" runat="server">
                    <div class="col-md-6">
                        <i class="fa-solid fa-user"></i>
                        <label class="form-label" style="font-weight: bold;">Name</label>
                        <asp:TextBox ID="txtName" class="form-control" placeholder="Enter name" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <i class="fa-solid fa-envelope"></i>
                        <label class="form-label" style="font-weight: bold;">E-Mail</label>
                        <asp:TextBox ID="txtEmail" type="email" class="form-control" placeholder="example@example.com" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <i class="fa-solid fa-mobile-screen"></i>
                        <label class="form-label" style="font-weight: bold;">Phone</label>
                        <asp:TextBox ID="txtPhone" class="form-control" placeholder="+8801500000000" pattern="[0-9,+]{14}" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <i class="fa-solid fa-location-pin"></i>
                        <label class="form-label" style="font-weight: bold;">Location</label>
                        <asp:DropDownList ID="dropLoc" class="form-control" runat="server">
                            <asp:ListItem Value="0" style="text-align: center;"><------- Select area -------></asp:ListItem>
                            <asp:ListItem>Dhaka</asp:ListItem>
                            <asp:ListItem>Chittagong</asp:ListItem>
                            <asp:ListItem>Sylhet</asp:ListItem>
                            <asp:ListItem>Rajshahi</asp:ListItem>
                            <asp:ListItem>Khulna</asp:ListItem>
                            <asp:ListItem>Barishal</asp:ListItem>
                            <asp:ListItem>Mymensing</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <i class="fa-solid fa-venus-mars"></i>
                        <label class="form-label" style="font-weight: bold;">Gender</label>
                        <div>
                            <asp:RadioButton ID="RadioButton1" class="r1" runat="server" />
                            <label class="form-label">Male</label>
                            <asp:RadioButton ID="RadioButton2" class="r2" runat="server" />
                            <label class="form-label">Female</label>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <i class="fa-solid fa-calendar-days"></i>
                        <label class="form-label" style="font-weight: bold;">Date of Donation</label>
                        <asp:TextBox ID="cal" class="form-control" type="date" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-5">
                        <i class="fa-solid fa-hand-holding-dollar"></i>
                        <label class="form-label" style="font-weight: bold;">Donation Amount</label>
                        <asp:TextBox ID="donate" class="form-control" placeholder="Enter amount" type="number" step="any" runat="server"></asp:TextBox>
                    </div>

                    <div class="col-md-12">
                        <div>
                            <asp:CheckBox ID="CheckBox1" class="check" runat="server" />
                            <label class="form-label">Check me out</label>
                        </div>
                    </div>

                    <div class="col-md-12">
                        <asp:Button  ID="add" runat="server" class="btn btn-primary" Style="font-weight: bold;" Text="Create" OnClick="add_Click"  />
                        <asp:Button ID="reset" runat="server" class="btn btn-secondary" Style="font-weight: bold;" Text="Reset" OnClick="reset_Click" />
                    </div>




                    <div class="table-responsive">

                        <asp:GridView ID="GridView1" ShowFooter="true" runat="server" AutoGenerateColumns="false"
                            CssClass="table table-striped table-hover table-bordered" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowDataBound="GridView1_RowDataBound" OnRowDeleting="GridView1_RowDeleting" OnRowUpdating="GridView1_RowUpdating">

                            <Columns>

                                <asp:TemplateField HeaderText="ID">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="id" Text='<%# Convert.ToInt32(DataBinder.Eval(Container.DataItem,"id"))%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"name"))%>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtName" class="form-control" Text='<%# Eval("name")%>' runat="server" CssClass="edit-textbox" />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="E-mail">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"email"))  %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEmail" class="form-control" type="email" Text='<%# Eval("email")%>' runat="server" CssClass="edit-textbox" />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Phone">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"phone")) %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPhone" pattern="[0-9,+]{14}" Text='<%# Eval("phone")%>' runat="server" CssClass="edit-textbox-phone" />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Location">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"location")) %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="txtLoc" class="form-control" Text='<%# Eval("location")%>' CssClass="edit-textbox-loc"  runat="server">
                                            <asp:ListItem Value="0" style="text-align: center;"><------- Select area -------></asp:ListItem>
                                            <asp:ListItem>Dhaka</asp:ListItem>
                                            <asp:ListItem>Chittagong</asp:ListItem>
                                            <asp:ListItem>Sylhet</asp:ListItem>
                                            <asp:ListItem>Rajshahi</asp:ListItem>
                                            <asp:ListItem>Khulna</asp:ListItem>
                                            <asp:ListItem>Barishal</asp:ListItem>
                                            <asp:ListItem>Mymensing</asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Gender">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"gendar")) %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        
                                        <asp:DropDownList ID="txtGen" class="form-control" Text='<%# Eval("gendar")%>'  CssClass="edit-textbox-gen"   runat="server">
                                            <asp:ListItem Value="0" style="text-align: center;"><------- Select gender -------></asp:ListItem>
                                            <asp:ListItem>Male</asp:ListItem>
                                            <asp:ListItem>Female</asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Date of Donation">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"dateCal","{0:MM-dd-yyyy}")) %>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCal" type="date" Text='<%# Eval("dateCal","{0:MM-dd-yyyy}")%>' runat="server" CssClass="edit-textbox-cal"  />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Donation Amount">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Convert.ToDecimal(Eval("donation")).ToString("0.00") %>' />
                                    </ItemTemplate>
                                     <EditItemTemplate>
                                        <asp:TextBox ID="txtD" type="number" step="any" Text='<%# Eval("donation")%>' runat="server" CssClass="edit-textbox-dona" />
                                     </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label runat="server" ID="totalAmt" Text="Total: " />
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Option">
                                    <ItemTemplate>
                                        <asp:Button ID="editB" runat="server" class="btn btn-warning" CommandName="Edit" Text="Edit"></asp:Button>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Button ID="upB" runat="server" class="btn btn-success" CommandName="Update" Text="Update"></asp:Button>
                                        <asp:Button ID="canB" runat="server" class="btn btn-secondary" CommandName="Cancel" Text="Cancel"></asp:Button>
                                        <asp:Button ID="delB" runat="server" class="btn btn-danger" CommandName="Delete" Text="Delete"></asp:Button>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                            </Columns>

                        </asp:GridView>
                    </div>
            </form>

        </div>
    </div>


    </div>

</body>

</html>

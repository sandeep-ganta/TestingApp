<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="GithubsampleApp.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>CPT Code to RadInfo Mapping Tool</title>
    <link href="Content/chosen.css" rel="stylesheet" />
    <link href="Content/jquery-ui.css" rel="stylesheet" />
    <link href="Content/jquery.ui.dialog.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
    <script src="Scripts/chosen.jquery.js"></script>
</head>
<style>
    .ex-table {
        width: 100%;
        padding: 0;
        margin: 0;
        float: left;
    }

        .ex-table thead {
            padding: 0;
            margin: 0;
        }

            .ex-table thead tr th {
                padding-bottom: 10px;
                margin: 0;
                font-size: 16px;
                font-weight: bold;
                font-family: Arial;
                color: #000;
            }

        .ex-table tbody tr td {
            padding-bottom: 20px;
            margin: 0;
            font-size: 16px;
            font-weight: normal;
            font-family: Arial;
            color: #666;
        }

    .txt-box {
        padding: 5px 4px;
        margin: 0px;
        background: #fff;
        border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;
        -webkit-border-radius: 5px;
        -ms-border-radius: 5px;
        color: #666;
        font-size: 12px;
        font-weight: normal;
        font-family: Arial;
        border: 1px solid #ccc;
        box-shadow: inset 0px 0px 4px 2px #eee;
        -moz-box-shadow: inset 0px 0px 4px 2px #eee;
        -o-box-shadow: inset 0px 0px 4px 2px #eee;
        -webkit-box-shadow: inset 0px 0px 4px 2px #eee;
        -ms-box-shadow: inset 0px 0px 4px 2px #eee;
    }

    .input-btn {
        width: 80px;
        padding: 4px;
        margin: 0px;
        cursor: pointer;
        background: #2692c1;
        border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;
        -webkit-border-radius: 5px;
        -ms-border-radius: 5px;
        color: #fff;
        font-size: 12px;
        font-weight: bold;
        font-family: Arial;
        border: 1px solid #07638b;
        box-shadow: 0px;
    }

    .rdoBtnlbltd label {
        margin-right: 25px;
    }
</style>
<body>
    <form id="form1" runat="server">
        <div>
            <h3 style="text-align: center">CPT Code to RadInfo Mapping Tool</h3>
            <br>
            <div style="border: 3px solid #666; padding: 15px;">
                <table width="100%" cellpadding="0" cellspacing="0" border="0" align="left" class="ex-table">

                    <thead>
                        <tr>
                            <th width="14%" align="left">Select CPT Code: 
                            </th>
                            <th width="15%" align="left">CPT Code: 
                            </th>
                            <th width="37%" align="left">Description: 
                            </th>
                            <th width="40%" align="left">RadiologyInfo URL:
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td align="left">
                                <asp:DropDownList ID="ddlcptcodes" runat="server" class="chzn-select" data_placeholder="Choose CptCodes.." Style="width: 60%">
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtcptcode" runat="server" Style="width: 80%" CssClass="txt-box">
                                </asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtradinfopage" runat="server" Style="width: 90%" CssClass="txt-box">
                                </asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtradinfourl" runat="server" Style="width: 90%" CssClass="txt-box">
                                </asp:TextBox>
                            </td>

                        </tr>
                        <tr>

                            <td colspan="4" class="rdoBtnlbltd">
                                <asp:RadioButton Text="Modify" runat="server" ID="rd_modify" GroupName="CPT" />
                                <asp:RadioButton ID="rd_delete" Text="Delete" runat="server" GroupName="CPT" />
                                <asp:RadioButton Text="Add" runat="server" ID="rd_add" GroupName="CPT" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="padding-bottom: 0;">
                                <table width="100%" cellpadding="0" cellspacing="0" border="0" align="left">
                                    <tr>
                                        <td align="right" width="49%">
                                            <input type="button" id="btnSave" value="Submit" class="input-btn" /></td>
                                        <td align="left" width="2%">&nbsp;</td>
                                        <td align="left" width="49%">
                                            <input type="button" id="btnClear" value="Clear" class="input-btn" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <%-- <asp:Button Text="Submit" runat="server" ID="btnsubmit" />--%>
                    </tbody>
                </table>
                <div style="clear: both;"></div>
            </div>
        </div>

    </form>
    <script type="text/javascript">
        $(".chzn-select").chosen({ allow_single_deselect: true });

        $(document).ready(function () {
            GetCptcodes();
            $('#txtcptcode').attr('disabled', false); $('#txtradinfopage').attr('disabled', false); $('#txtradinfourl').attr('disabled', false);
        });

        $("#ddlcptcodes").chosen().change(function () {
            if ($('#ddlcptcodes option:selected').val() != undefined && $('#ddlcptcodes option:selected').val() != "") {

                var data = { cptcode: $("#ddlcptcodes").chosen().val() };
                var cptcode = JSON.stringify(data);

                $.ajax({
                    url: "AcrSelectCptinfo.aspx/GetCptinfobased",
                    type: "POST",
                    data: cptcode,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function OnSuccess(data) {
                        $('#txtcptcode').val(data.d.CPTcode);
                        $('#txtradinfopage').val(data.d.RadInfoPage);
                        $('#txtradinfourl').val(data.d.Radinfourl);
                        $('#txtcptcode').attr('disabled', 'disabled'); $('#txtradinfopage').attr('disabled', 'disabled'); $('#txtradinfourl').attr('disabled', 'disabled');
                    }
                });

                $("#ddlcptcodes").trigger("chosen:updated");
                $('#rd_add').attr("checked", false);
                $('#rd_delete').attr("checked", false);
                $('#rd_modify').attr("checked", false);
                $('#txtcptcode').attr('disabled', false); $('#txtradinfopage').attr('disabled', false); $('#txtradinfourl').attr('disabled', false)
            }
            else { $('#txtcptcode').val(''); $('#txtradinfopage').val(''); $('#txtradinfourl').val(''); alert("Please select Subtopic"); return false; }
        });

        $('#rd_add').change(function (event) {
            $('#txtcptcode').val(''); $('#txtradinfopage').val(''); $('#txtradinfourl').val('');
            $('#txtcptcode ,#txtradinfopage, #txtradinfourl').attr('disabled', false);
            $("#ddlcptcodes").val('').trigger("chosen:updated");
        });

        $('#rd_delete').change(function (event) {
            $('#txtcptcode').attr('disabled', 'disabled'); $('#txtradinfopage').attr('disabled', 'disabled'); $('#txtradinfourl').attr('disabled', 'disabled');
        });

        $('#rd_modify').change(function (event) {
            $('#txtcptcode').attr('disabled', 'disabled'); $('#txtradinfopage').attr('disabled', false); $('#txtradinfourl').attr('disabled', false)
        });

        $('#btnSave').click(function (event) {

            // if ($('#ddlcptcodes').chosen().val() != undefined && $('#ddlcptcodes').chosen().val() != "") {
            //if ($.trim($('#txtcptcode').val()) != "" && $.trim($('#txtradinfopage').val()) != "" && $.trim($('#txtradinfourl').val()) != "") {
            if ($("#rd_add").is(":checked") || $("#rd_delete").is(":checked") || $("#rd_modify").is(":checked")) {

                var radinfo = {
                    CPTcode: $('#txtcptcode').val(),
                    RadInfoPage: $("#txtradinfopage").val(),
                    Radinfourl: $("#txtradinfourl").val()
                };

                if ($("#rd_add").is(":checked")) {
                    if ($.trim($('#txtcptcode').val()) == '') {
                        alert("Please Enter CPT Code to Add");
                        return false;
                    }
                    else {
                        var regurl = new RegExp("^(http:\/\/www.|https:\/\/www.|ftp:\/\/www.|www.){1}([0-9A-Za-z?&=]+\.)");

                        if (!regurl.test($('#txtradinfourl').val())) {
                            alert("Enter valid Url");
                            return false;
                        }

                        var NewDialog = $('<div id="AddCptCode">\
                            <p><span style="float: left; margin: 0 7px 20px 0;"></span>&nbsp;&nbsp;Are you sure you want to Add the CPT Code and its corresponding details?</p>\
                      </div>');
                        NewDialog.dialog({
                            modal: true,
                            title: "Add CPT Code",
                            buttons: [
                                {
                                    text: "OK", click: function () {
                                        Successevent(radinfo, 'AddNewCptinfo');
                                        $(this).dialog("close");
                                    }
                                },
                { text: "Cancel", click: function () { $(this).dialog("close") } }
                            ]
                        });
                        //if (confirm("Are you sure you want to Add the CPT Code and its corresponding details?")) { 
                        //}
                    }
                }

                if ($("#rd_delete").is(":checked")) {
                    if ($('#ddlcptcodes').chosen().val() != undefined && $('#ddlcptcodes').chosen().val() != "") {
                        var NewDialog = $('<div id="DeleteCPTCode">\
                            <p><span style="float: left; margin: 0 7px 20px 0;"></span>&nbsp;&nbsp;Are you sure you want to Delete the CPT Code and its corresponding details?</p>\
                      </div>');
                        NewDialog.dialog({
                            modal: true,
                            title: "Delete CPT Code",
                            buttons: [
                                {
                                    text: "OK", click: function () {
                                        Successevent(radinfo, 'Deletecptinfo');
                                        $(this).dialog("close");
                                    }
                                },
                { text: "Cancel", click: function () { $(this).dialog("close") } }
                            ]
                        });

                        //if (confirm("Are you sure you want to Delete the CPT Code and its corresponding details?")) {
                        //    Successevent(radinfo, 'Deletecptinfo');
                        //}
                    }
                    else { $('#txtcptcode').val(''); $('#txtradinfopage').val(''); $('#txtradinfourl').val(''); alert("Please select CPT Code"); return false; }
                }
                if ($("#rd_modify").is(":checked")) {
                    if ($('#ddlcptcodes').chosen().val() != undefined && $('#ddlcptcodes').chosen().val() != "") {

                        var NewDialog = $('<div id="UpdateCPTCode">\
                            <p><span style="float: left; margin: 0 7px 20px 0;"></span>&nbsp;&nbsp;Are you sure you want to Update the CPT Code and its corresponding details?</p>\
                      </div>');
                        NewDialog.dialog({
                            modal: true,
                            title: "Update CPT Code",
                            buttons: [
                                {
                                    text: "OK", click: function () {
                                        Successevent(radinfo, 'Updatecptinfo'); $(this).dialog("close");
                                    }
                                },
                { text: "Cancel", click: function () { $(this).dialog("close") } }
                            ]
                        });

                        //if (confirm("Are you sure you want to Update the CPT Code and its corresponding details?")) {
                        //    Successevent(radinfo, 'Updatecptinfo');
                        //}
                    }
                    else { $('#txtcptcode').val(''); $('#txtradinfopage').val(''); $('#txtradinfourl').val(''); alert("Please select CPT Code"); return false; }
                }
            } else { alert("Please Select Any of Operation to Perform"); return false; }
            //}
            //  else { alert("Please Enter ALL values"); return false; }
            //}
            //  else { $('#txtcptcode').val(''); $('#txtradinfopage').val(''); $('#txtradinfourl').val(''); alert("Please select Subtopic"); return false; }
        });

        function Successevent(data, event) {

            var data = { radinfo: data };
            var radinfo = JSON.stringify(data);
            var url = "AcrSelectCptinfo.aspx/" + event;
            $.ajax({
                url: url,
                type: "POST",
                data: radinfo,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function OnSuccess(data) {
                    $("#ddlcptcodes").val('').trigger("chosen:updated");
                    $('#rd_add, #rd_delete, #rd_modify').attr("checked", false);
                    $('#txtcptcode').val(''); $('#txtradinfopage').val(''); $('#txtradinfourl').val('');
                    $('#txtcptcode ,#txtradinfopage, #txtradinfourl').attr('disabled', false);

                    var NewDialog = $('<div id="showdialog"><label>' + data.d + '</label> </div>');
                    NewDialog.dialog({
                        modal: true,
                        resize: false,
                        height: 'auto',
                        buttons: [
                            {
                                text: "OK", click: function () {
                                    $(this).dialog("close");
                                }
                            },
                        ]
                    });
                    //$('.ex-col3').trigger('click');
                    //window.location.reload();
                    GetCptcodes();
                }
            });
        }

        function GetCptcodes() {
            $.ajax({
                url: "AcrSelectCptinfo.aspx/GetCPTcodeslist",
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function OnSuccess(data) {
                    var items;
                    items = "<option value=''>" + '--Select--' + "</option>",
                    $.each(data.d, function (i, item) {
                        items += "<option value=\"" + item + "\">" + item + "</option>";
                    });
                    $("#ddlcptcodes").empty().append(items);

                    $("#ddlcptcodes").trigger("chosen:updated");
                }
            });
        }

        $('#btnClear').click(function (event) {
            $("#ddlcptcodes").val('').trigger("chosen:updated");
            $('#txtcptcode').val(''); $('#txtradinfopage').val(''); $('#txtradinfourl').val('');
            $('#txtcptcode ,#txtradinfopage, #txtradinfourl').attr('disabled', false);
        });
    </script>
</body>
</html>
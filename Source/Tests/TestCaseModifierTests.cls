VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "TestCaseModifierTests"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Copyright 2009 Kelly Ethridge
'
' Licensed under the Apache License, Version 2.0 (the "License");
' you may not use this file except in compliance with the License.
' You may obtain a copy of the License at
'
'     http://www.apache.org/licenses/LICENSE-2.0
'
' Unless required by applicable law or agreed to in writing, software
' distributed under the License is distributed on an "AS IS" BASIS,
' WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
' See the License for the specific language governing permissions and
' limitations under the License.
'
' Module: TestCaseModifierTests
'
Option Explicit

Public Sub Throws_WithNumber_StoresErrorInfo()
    Dim Data As New TestCaseData
    Dim Modifier As TestCaseModifier
    Set Modifier = Sim.NewTestCaseModifier(Data)
    
    Modifier.Throws 10
    
    Dim Actual As ErrorInfo
    Set Actual = Data.ErrorInfo
    Dim Expected As ErrorInfo
    Set Expected = Sim.NewErrorInfo(10)
    Assert.IsTrue Actual.Equals(Expected)
End Sub

Public Sub Expect_WithConstraint_StoresConstraint()
    Dim Data As New TestCaseData
    Dim Modifier As TestCaseModifier
    Set Modifier = Sim.NewTestCaseModifier(Data)
    Dim Fake As New StubConstraint
    
    Modifier.Expect Fake
    
    Dim Actual As IConstraint
    Set Actual = Data.Expected
    Assert.IsTrue Actual Is Fake
End Sub

Public Sub Expect_WithNonconstraint_CreatesEqualConstraint()
    Dim Data As New TestCaseData
    Dim Modifier As TestCaseModifier
    Set Modifier = Sim.NewTestCaseModifier(Data)
    
    Modifier.Expect 1
    
    Dim Actual As IConstraint
    Set Actual = Data.Expected
    Assert.IsTrue TypeOf Actual Is EqualConstraint
End Sub

Public Sub Expect_WithNothing_CreatesEqualConstraint()
    Dim Data As New TestCaseData
    Dim Modifier As TestCaseModifier
    Set Modifier = Sim.NewTestCaseModifier(Data)
    
    Modifier.Expect Nothing
    
    Dim Actual As IConstraint
    Set Actual = Data.Expected
    Assert.IsTrue TypeOf Actual Is EqualConstraint
End Sub

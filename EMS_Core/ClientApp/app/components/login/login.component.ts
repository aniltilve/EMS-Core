import { Component } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { Http } from '@angular/http';
import { getBaseUrl } from '../../app.browser.module';
import { Login } from '../../models/login';

@Component({
    selector: 'login',
    templateUrl: './login.component.html',
    styleUrls: ['./login.component.css']
})
export class LoginComponent {
    public hideAgencyError: boolean;
    public userExists: boolean;
    model: any = {};

    constructor(private http: Http) {
        this.hideAgencyError = true;
        this.userExists = true;
    }

    onSubmit() {
        var url = window.location.origin + '/api/login';
        var login: Login = { agency: this.model.agency, username: this.model.username, password: this.model.password };
        var res = this.http.post(url, login);
        console.log(res);
    }

    reset(event: any) {
        switch (event.target.id) {
            case "agency": {
                this.hideAgencyError = true;
                break;
            }
        }
    }
}

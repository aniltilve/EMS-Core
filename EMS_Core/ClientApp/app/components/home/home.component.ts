import { Component } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { Http } from '@angular/http';
import { getBaseUrl } from '../../app.browser.module';

@Component({
    selector: 'home',
    templateUrl: './home.component.html',
    styleUrls: ['./home.component.css']
})
export class HomeComponent {
    public hideAgencyError: boolean;
    public userExists: boolean;

    constructor(private http: Http) {
        this.hideAgencyError = true;
        this.userExists = true;
    }

    validate(value: string) {
        this.hideAgencyError = false;
        var url = window.location.origin;
        this.http.post('api/login', null);
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
